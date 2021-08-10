resource "google_service_account" "ldap-storage" {
  project      = var.project
  account_id   = "ldap-storage"
  display_name = "LDAP Storage"
}

resource "google_storage_bucket_iam_member" "creater-storage-account-iam" {
  bucket = google_storage_bucket.ldap-config-bucket.name
  role   = var.role-bucket
  member = "serviceAccount:${google_service_account.ldap-storage.email}"
}