variable "digitalocean_token" {
  default = ""
}

variable "ssh_key_name" {
  default = ""
}

variable "region" {
  default = ""
}

variable "droplet_size" {
  default = ""
}

variable "droplet_image" {
  default = ""
}

variable "k8s_master_nodes_name" {
  type = list
}

variable "k8s_worker_nodes_name" {
  type = list
}
