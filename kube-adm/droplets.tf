resource "digitalocean_droplet" "k8s-master" {
  count = length(var.master_nodes_name)
  image = var.droplet_image
  name = var.master_nodes_name[count.index]
  region = var.region
  size = var.droplet_size
  ssh_keys = [ data.digitalocean_ssh_key.ssh_key.fingerprint ]
  depends_on = [digitalocean_project.k8s-project]
}

resource "digitalocean_project" "k8s-project" {
  name = "my-k8s-project"
  description = "Setting up Kubernetes Cluster with kube-adm"
}

resource "digitalocean_project_resources" "k8s-master-nodes" {
  count = length(var.master_nodes_name)
  project = digitalocean_project.k8s-project.id
  resources = [ digitalocean_droplet.k8s-master[count.index].urn]
  depends_on = [digitalocean_droplet.k8s-master]
}