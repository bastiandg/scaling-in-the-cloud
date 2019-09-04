provider "google" {
  version = "~> 2.12"
  project = var.project
}

resource "google_container_cluster" "cluster" {
  name     = "${var.service_name}-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "scaling_pool" {
  name     = "${var.service_name}-pool"
  location = var.region
  cluster  = "${google_container_cluster.cluster.name}"

  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }

  node_config {
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }
}

