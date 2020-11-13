output "jenkins_master_ip" {
  value = digitalocean_droplet.jenkins-master.ipv4_address
}

output "jenkins_slave_ip" {
  value = digitalocean_droplet.jenkins-slave.ipv4_address
}