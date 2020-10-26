provider "digitalocean" {
  token = var.digitalocean_token
}

data "digitalocean_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}