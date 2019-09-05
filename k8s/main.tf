provider "google" {
  version = "~> 2.12"
  project = var.project
}

resource "google_container_cluster" "cluster" {
  name     = "${var.service_name}-cluster"
  location = var.k8s_location

  remove_default_node_pool = true
  initial_node_count       = 1
  min_master_version       = var.min_master_version

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
  location = var.k8s_location
  cluster  = "${google_container_cluster.cluster.name}"

  initial_node_count = var.min_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
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
  lifecycle {
    ignore_changes = [
      initial_node_count,
    ]
  }
}

