resource "digitalocean_project" "jenkins-project" {
  name = "jenkins-project"
}

resource "digitalocean_droplet" "jenkins-server" {
  image = var.droplet_image
  name = var.jenkins_node_name
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [digitalocean_project.jenkins-project]
}

resource "digitalocean_project_resources" "jenkins" {
  project = digitalocean_project.jenkins-project.id
  resources = [ digitalocean_droplet.jenkins-server.urn]
  depends_on = [digitalocean_droplet.jenkins-server]
}

