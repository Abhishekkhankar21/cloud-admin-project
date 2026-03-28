output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}

output "ansible_ip" {
  value = aws_instance.ansible.public_ip
}

output "monitoring_ip" {
  value = aws_instance.monitoring.public_ip
}