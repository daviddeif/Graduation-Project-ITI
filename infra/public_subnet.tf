resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id

}


resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.management-subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_address" "nataddress" {
  name   = "nataddress"
  region = google_compute_subnetwork.management-subnet.region
}
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nataddress.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
