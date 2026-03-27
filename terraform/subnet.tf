# Public Subnet
resource "aws_subnet" "devops_public_subnet" {

  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-subnet"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "devops_igw" {

  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-igw"
  }

}


# Public Route Table
resource "aws_route_table" "devops_public_rt" {

  vpc_id = aws_vpc.devops_vpc.id

  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id

  }

  tags = {
    Name = "devops-public-rt"
  }

}


# Route Table Association
resource "aws_route_table_association" "devops_public_rta" {

  subnet_id      = aws_subnet.devops_public_subnet.id
  route_table_id = aws_route_table.devops_public_rt.id

}