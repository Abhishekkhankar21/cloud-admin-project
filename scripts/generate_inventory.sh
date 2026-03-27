#!/bin/bash

echo "Fetching Terraform outputs..."

# Navigate to terraform directory
cd ../terraform

# Get IPs from terraform outputs
JENKINS_IP=$(terraform output -raw jenkins_ip)
ANSIBLE_IP=$(terraform output -raw ansible_ip)
MONITORING_IP=$(terraform output -raw monitoring_ip)

# Go back to project root
cd ..

echo "Updating Ansible inventory..."

cat > ansible/inventory <<EOF
[jenkins]
$JENKINS_IP

[ansible]
$ANSIBLE_IP

[monitoring]
$MONITORING_IP
EOF

echo "Inventory successfully updated!"
echo "-------------------------------"
cat ansible/inventory
