resource "google_service_account" "service-for-vm" {
  account_id   = "service-for-vm"
  project = "david-emad-project"
  
}
resource "google_project_iam_member" "instance-account" {
  project = "david-emad-project"
  role    ="roles/container.admin"
  member  = "serviceAccount:${google_service_account.service-for-vm.email}"
}
