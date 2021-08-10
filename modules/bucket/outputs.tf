output "service-account-email" {
  value = google_service_account.ldap-storage.email
}

output "bucket-url" {
  value = google_storage_bucket.ldap-config-bucket.url
}