resource "google_compute_instance" "ldap" {
  project       = var.project
  zone          = var.zones
  name          = var.name
  machine_type  = var.machine-type

  boot_disk {
    initialize_params {
      image         = var.image
    }
  }

  network_interface {
    network     = var.network
  access_config{}
  }
 
  service_account {
    email  = var.service-account-email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = var.startup-script
}