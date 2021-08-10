module "ldap-storage" {
  source      = "./modules/bucket"
  project     = var.project
  region      = var.region
  bucket-name = "${var.project}-ldap-bucket"
  role-bucket = "roles/storage.objectAdmin"
}

module "ldap-server" {
  source  = "./modules/instance"
  project = var.project
  name    = "ldap-server"
  network = "default"
  service-account-email = module.ldap-storage.service-account-email
  startup-script = "mkdir /resources && cd /resources ; gsutil cp -r ${module.ldap-storage.bucket-url}/resources/* . ; chmod 744 server.sh; ./server.sh"
}

module "ldap-client" {
  source  = "./modules/instance"
  project = var.project
  name    = "ldap-client"
  network = "default"
  service-account-email = module.ldap-storage.service-account-email
  startup-script = "mkdir -p /resources && cd /resources; gsutil cp -r ${module.ldap-storage.bucket-url}/resources/* . ; chmod 744 client.sh; export LDAP_IP_ADDRESS=${module.ldap-server.ip-vm}; ./client.sh"
}