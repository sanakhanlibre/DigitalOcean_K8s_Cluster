output "jenkins_server_ip" {
  value = digitalocean_droplet.jenkins-server.ipv4_address
}