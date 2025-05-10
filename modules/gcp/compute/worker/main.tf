resource "google_compute_instance" "worker" {
  count        = var.gcp_worker_count
  name         = "${var.gcp_worker_name}-${count.index}"
  machine_type = var.machine_type 
  zone         = "${var.gcp_region}-a"

  tags = ["k8s-worker"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20240515"
      size  = 30 # 30 GB disk
    }
  }

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_name
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
}