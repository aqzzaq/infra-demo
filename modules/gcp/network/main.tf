resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "public" {
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  network       = google_compute_network.vpc.self_link
  region        = var.region
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  network       = google_compute_network.vpc.self_link
  region        = var.region
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [var.public_subnet_cidr, var.private_subnet_cidr]
}

resource "google_compute_firewall" "allow_external" {
  name    = "allow-external"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}