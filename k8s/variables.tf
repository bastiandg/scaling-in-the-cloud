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

variable "region" {
  type = string
}
