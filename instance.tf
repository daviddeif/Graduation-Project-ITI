resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  depends_on = [google_container_cluster.private-cluster]

  service_account {
    email = google_service_account.service-for-vm.email
    scopes = [ "cloud-platform" ]
  }
  
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      type = "pd-standard"
      size = 10
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.management-subnet.id

  }
  
}

resource "google_compute_firewall" "allow-ingress-from-iap" {
  name    = "allow-ingress-from-iap"
  network = google_compute_network.vpc_network.id
  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"] 
  # IP addresses that IAP uses for TCP forwarding.


  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  
}