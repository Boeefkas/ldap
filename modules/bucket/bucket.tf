resource "google_storage_bucket" "ldap-config-bucket" {
  name          = var.bucket-name
  project       = var.project
  location      = var.region
  force_destroy = var.destroy
  storage_class = var.storage-class
}

resource "google_storage_bucket_object" "baseldapdomain" {
  name   = "resources/baseldapdomain.ldif"
  source = "resources/baseldapdomain.ldif"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "ldapdomain" {
  name   = "resources/ldapdomain.ldif"
  source = "resources/ldapdomain.ldif"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "ldapgroup" {
  name   = "resources/ldapgroup.ldif"
  source = "resources/ldapgroup.ldif"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "ldaprootpasswd" {
  name   = "resources/ldaprootpasswd.ldif"
  source = "resources/ldaprootpasswd.ldif"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "ldapuser" {
  name   = "resources/ldapuser.ldif"
  source = "resources/ldapuser.ldif"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "server-build" {
  name   = "resources/server.sh"
  source = "scripts/server.sh"
  bucket = google_storage_bucket.ldap-config-bucket.name
}

resource "google_storage_bucket_object" "client-build" {
  name   = "resources/client.sh"
  source = "scripts/client.sh"
  bucket = google_storage_bucket.ldap-config-bucket.name
}