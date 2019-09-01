provider "google" {
  version = "~> 2.12"
  project = var.project
}

resource "google_compute_instance_template" "appserver_template" {
  name         = "${var.service_name}-template"
  description  = "This template is used to create ${var.service_name} server instances."
  machine_type = var.machine_type
  tags         = ["http-server"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"
    }
  }

  // Create a new boot disk from an image
  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }
}


#resource "google_compute_health_check" "autohealing" {
#name                = "autohealing-health-check"
#check_interval_sec  = 5
#timeout_sec         = 5
#healthy_threshold   = 2
#unhealthy_threshold = 10 # 50 seconds

#http_health_check {
#request_path = "/"
#port         = "80"
#}
#}

resource "google_compute_region_instance_group_manager" "appserver" {
  name               = "${var.service_name}-mig"
  base_instance_name = "${var.service_name}"
  instance_template  = "${google_compute_instance_template.appserver_template.self_link}"
  region             = var.region
}

resource "google_compute_region_autoscaler" "autoscaler" {
  name   = "autoscaler-${var.service_name}"
  region = var.region
  target = google_compute_region_instance_group_manager.appserver.self_link

  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}

