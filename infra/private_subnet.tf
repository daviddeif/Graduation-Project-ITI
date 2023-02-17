resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id

}


resource "google_compute_address" "jenkinsaddress" {
  name = "jenkinsaddress"
  region = google_compute_subnetwork.restricted-subnet.region
}

resource "google_compute_router" "router-jenkins" {
  name    = "router-jenkins"
  region  = google_compute_subnetwork.restricted-subnet.region 
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "private-nat" {
  name                               = "private-nat"
  router                             = google_compute_router.router-jenkins.name
  region                             = google_compute_router.router-jenkins.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.jenkinsaddress.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.restricted-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}