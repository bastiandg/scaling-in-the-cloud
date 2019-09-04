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

  named_port {
    name = "http"
    port = 80
  }
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

resource "google_compute_http_health_check" "lb_health_check" {
  name         = "${var.service_name}-health-check"
  request_path = "/healthz"

  timeout_sec        = 1
  check_interval_sec = 1
  port               = 80
}

resource "google_compute_backend_service" "backend_service" {
  name          = "backend-service"
  port_name     = "http"
  protocol      = "HTTP"
  health_checks = ["${google_compute_http_health_check.lb_health_check.self_link}"]
  backend {
    group = google_compute_region_instance_group_manager.appserver.instance_group
  }
}

# HTTP proxy when ssl is false
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "${var.service_name}-http-forwarder"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  ip_address = google_compute_global_address.external_ip.address
  port_range = "80"
  depends_on = [google_compute_global_address.external_ip]
}

resource "google_compute_global_address" "external_ip" {
  name = "${var.service_name}-address"
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.backend_service.self_link
}

output "vm_lb_ip_address" {
  description = "IP address of the loadbalancer for the managed instance group"
  value       = google_compute_global_address.external_ip.address
}
