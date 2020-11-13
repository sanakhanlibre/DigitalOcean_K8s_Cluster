resource "digitalocean_project" "jenkins-project" {
  name = "jenkins-project"
}

resource "digitalocean_droplet" "jenkins-master" {
  image = var.droplet_image
  name = var.jenkins_master_name
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [digitalocean_project.jenkins-project]
}

resource "digitalocean_droplet" "jenkins-slave" {
  image = var.droplet_image
  name = var.jenkins_slave_name
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [digitalocean_project.jenkins-project]
}

resource "digitalocean_project_resources" "jenkins-master-01" {
  project = digitalocean_project.jenkins-project.id
  resources = [ digitalocean_droplet.jenkins-master.urn]
  depends_on = [digitalocean_droplet.jenkins-master]
}

resource "digitalocean_project_resources" "jenkins-slave-01" {
  project = digitalocean_project.jenkins-project.id
  resources = [ digitalocean_droplet.jenkins-slave.urn]
  depends_on = [digitalocean_droplet.jenkins-slave]
}
