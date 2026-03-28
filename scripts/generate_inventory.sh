#!/bin/bash

echo "Fetching Terraform outputs..."

# Navigate to terraform directory
cd ../terraform

# Get IPs from terraform outputs
App_server_ip=$(terraform output -raw app_server_ip)
ANSIBLE_IP=$(terraform output -raw ansible_ip)
MONITORING_IP=$(terraform output -raw monitoring_ip)

# Go back to project root
cd ..

echo "Updating Ansible inventory..."

cat > ansible/inventory <<EOF
[App_servers]
$App_server_ip

[ansible]
$ANSIBLE_IP

[monitoring]
$MONITORING_IP

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/jenkins-key.pem
EOF

echo "Inventory successfully updated!"
echo "-------------------------------"
cat ansible/inventory
