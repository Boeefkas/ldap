provider "google" {
  credentials = "${file("service-account.json")}"
  project = var.project
  region  = var.region
  zone    = var.zone
}