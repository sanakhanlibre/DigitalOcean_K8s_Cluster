resource "digitalocean_project" "k8s-project" {
  name = "k8s-project"
}

resource "digitalocean_droplet" "k8s-master" {
  count = length(var.k8s_master_nodes_name)
  image = var.droplet_image
  name = var.k8s_master_nodes_name[count.index]
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [digitalocean_project.k8s-project]
}

resource "digitalocean_droplet" "k8s-workers" {
  count = length(var.k8s_worker_nodes_name)
  image = var.droplet_image
  name = var.k8s_worker_nodes_name[count.index]
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [digitalocean_project.k8s-project]
}

resource "digitalocean_project_resources" "k8s-master-nodes" {
  count = length(var.k8s_master_nodes_name)
  project = digitalocean_project.k8s-project.id
  resources = [ digitalocean_droplet.k8s-master[count.index].urn]
  depends_on = [digitalocean_droplet.k8s-master]
}

resource "digitalocean_project_resources" "k8s-worker-nodes" {
  count = length(var.k8s_worker_nodes_name)
  project = digitalocean_project.k8s-project.id
  resources = [ digitalocean_droplet.k8s-workers[count.index].urn]
  depends_on = [digitalocean_droplet.k8s-workers]
}