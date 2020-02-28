variable "creds"{}
provider "google" {
  credentials = var.creds
  project = "devops-260809"
  region = "us-central1"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default" {
  name = "ansible-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone = "us-central1-a"

  boot_disk{
      initialize_params {
          image = "debian-cloud/debian-9"
      }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install --user ansible"

  network_interface {
      network = "default"
      access_config{
          // Include this section to give the VM an external ip address
      }
  }

}
