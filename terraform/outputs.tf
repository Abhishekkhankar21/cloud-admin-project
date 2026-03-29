output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}

output "ansible_ip" {
  value = aws_instance.ansible.public_ip
}

output "monitoring_ip" {
  value = aws_instance.monitoring.public_ip
}