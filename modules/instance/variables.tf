variable "project" {
  type    = string
  default = "gcp-lab-1-pmatsiusheuski"
}

variable "image" {
  type    = string
  default = "centos-cloud/centos-7"
}

variable "zones" {
  type    = string
  default = "us-central1-c"
}

variable "network" {
  type = string
  default = "default"
}

variable "machine-type" {
  type    = string
  default = "custom-1-4096"
}

variable "startup-script" {
  type = string
}

variable "name" {
  type = string
}

variable "service-account-email" {
  type = string
}