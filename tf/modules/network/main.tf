resource "google_compute_network" "vpc_network" {
  name                    = "zonal-test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-a" {
  name          = "subnet-a"
  ip_cidr_range = "10.0.0.0/10"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "subnet-b" {
  name          = "subnet-b"
  ip_cidr_range = "10.64.0.0/10"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "subnet-c" {
  name          = "subnet-c"
  ip_cidr_range = "10.128.0.0/10"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "network-for-l7lb" {
  provider = google-beta

  name          = "subnet-l7lb"
  ip_cidr_range = "10.1920.0/10"
  region        = var.region
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
  network       = google_compute_network.vpc_network.self_link
}
