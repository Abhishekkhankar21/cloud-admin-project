# App Server
resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "jenkins-key"            # Replace with your SSH key

  subnet_id              = aws_subnet.devops_public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  associate_public_ip_address = true
  monitoring                  = true

  tags = {
    Name        = "App-server"
    Environment = "dev"
    Project     = "cloud-devops"
  }
}


# Ansible Server
resource "aws_instance" "ansible" {

  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  key_name                    = "jenkins-key"

  subnet_id              = aws_subnet.devops_public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  associate_public_ip_address = true

  monitoring                  = true

  tags = {
    Name = "ansible-server"
    Environment = "prod"
    Project = "cloud-devops"
  }
}



# Monitoring Server
resource "aws_instance" "monitoring" {

  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  key_name                    = "jenkins-key"

   subnet_id              = aws_subnet.devops_public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  associate_public_ip_address = true

  monitoring                  = true

  tags = {
    Name = "monitoring-server"
    Environment = "dev and prod"
    Project = "cloud-devops"
  }
}