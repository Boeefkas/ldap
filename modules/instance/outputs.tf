output "ip-vm" {
  value = google_compute_instance.ldap.network_interface.0.network_ip
}