provider "google" {
  project     = "david-emad-project"
  region      = "europe-west1"
  credentials = file("/home/david/Downloads/david-emad-project-gcp.json")
}

resource "google_compute_network" "vpc_network" {
  project                 = "david-emad-project"
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

