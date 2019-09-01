variable "project" {
  type = string
}

variable "service_name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "source_image" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}
