output "k8s_master_nodes_ip" {
  value = digitalocean_droplet.k8s-master.*.ipv4_address
}

output "k8s_worker_nodes_ip" {
  value = digitalocean_droplet.k8s-workers.*.ipv4_address
}