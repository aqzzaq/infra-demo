resource "google_compute_instance" "control_plane" {
  count        = var.gcp_master_count
  name         = "${var.gcp_master_name}-${count.index}"
  machine_type = var.machine_type
  zone         = "${var.gcp_region}-a"

  tags = ["k8s-control-plane"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20240515" # Ubuntu 22.04 LTS
      size  = var.disk_size
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