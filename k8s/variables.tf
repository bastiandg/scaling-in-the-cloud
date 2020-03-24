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

variable "k8s_location" {
  type = string
}

variable "min_node_count" {
  type = number
}

variable "max_node_count" {
  type = number
}

variable "min_master_version" {
  type    = string
  default = null
}
