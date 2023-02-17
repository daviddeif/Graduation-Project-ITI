resource "google_service_account" "service-for-vm" {
  account_id   = "service-for-vm"
  project = "david-emad-project"
  
}
resource "google_project_iam_member" "instance-account" {
  project = "david-emad-project"
  role    ="roles/container.admin"
  member  = "serviceAccount:${google_service_account.service-for-vm.email}"
}
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.service-for-vm.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "service_account" {
    content  = base64decode(google_service_account_key.mykey.private_key)
    filename = "/home/david/Documents/serviceaccount.json"
}