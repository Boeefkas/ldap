variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "bucket-name" {
  type    = string
  default = "ldap-config-bucket"
}

variable "storage-class" {
  type    = string
  default = "STANDARD"
}

variable "destroy" {
  type    = string
  default = "true"
}

variable "role-bucket" {
  type    = string
  default = "roles/storage.objectAdmin"
}