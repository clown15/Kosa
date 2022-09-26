# vi bmo-vpc.tf
provider "aws" {
  region = "ap-northeast-2"
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_vpc" "bmo_vpc" {
  cidr_block  = "10.29.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "BMO-VPC"
  }
}
resource "aws_subnet" "bmo_public_subnet_2a" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.0.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "BMO-PUBLIC-SUBNET-2A"
  }
}
resource "aws_subnet" "bmo_public_subnet_2b" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.16.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "BMO-PUBLIC-SUBNET-2B"
  }
}
resource "aws_subnet" "bmo_public_subnet_2c" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.32.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "BMO-PUBLIC-SUBNET-2C"
  }
}
resource "aws_subnet" "bmo_public_subnet_2d" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.48.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[3]
  tags = {
    Name = "BMO-PUBLIC-SUBNET-2D"
  }
}
resource "aws_internet_gateway" "bmo_igw" {
  vpc_id = aws_vpc.bmo_vpc.id
  tags = {
    Name = "BMO-IGW"
  }
}
resource "aws_route_table" "bmo_public_rtb" {
  vpc_id = aws_vpc.bmo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bmo_igw.id
  }
  tags = {
    Name = "BMO-PUBLIC-SUBNET-RTB"
  }
}
resource "aws_route_table_association" "bmo_public_subnet_2a_association" {
  subnet_id = aws_subnet.bmo_public_subnet_2a.id
  route_table_id = aws_route_table.bmo_public_rtb.id
}
resource "aws_route_table_association" "bmo_public_subnet_2b_association" {
  subnet_id = aws_subnet.bmo_public_subnet_2b.id
  route_table_id = aws_route_table.bmo_public_rtb.id
}
resource "aws_route_table_association" "bmo_public_subnet_2c_association" {
  subnet_id = aws_subnet.bmo_public_subnet_2c.id
  route_table_id = aws_route_table.bmo_public_rtb.id
}
resource "aws_route_table_association" "bmo_public_subnet_2d_association" {
  subnet_id = aws_subnet.bmo_public_subnet_2d.id
  route_table_id = aws_route_table.bmo_public_rtb.id
}


resource "aws_subnet" "bmo_private_subnet_2a" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.64.0/20"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "BMO-PRIVATE-SUBNET-2A"
  }
}
resource "aws_subnet" "bmo_private_subnet_2b" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.80.0/20"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "BMO-PRIVATE-SUBNET-2B"
  }
}
resource "aws_subnet" "bmo_private_subnet_2c" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.96.0/20"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "BMO-PRIVATE-SUBNET-2C"
  }
}
resource "aws_subnet" "bmo_private_subnet_2d" {
  vpc_id = aws_vpc.bmo_vpc.id
  cidr_block = "10.29.112.0/20"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[3]
  tags = {
    Name = "BMO-PRIVATE-SUBNET-2D"
  }
}



resource "aws_route_table_association" "bmo_private_subnet_2a_association" {
  subnet_id = aws_subnet.bmo_private_subnet_2a.id
  route_table_id = aws_route_table.bmo_private_rtb.id
}
resource "aws_route_table_association" "bmo_private_subnet_2b_association" {
  subnet_id = aws_subnet.bmo_private_subnet_2b.id
  route_table_id = aws_route_table.bmo_private_rtb.id
}
resource "aws_route_table_association" "bmo_private_subnet_2c_association" {
  subnet_id = aws_subnet.bmo_private_subnet_2c.id
  route_table_id = aws_route_table.bmo_private_rtb.id
}
resource "aws_route_table_association" "bmo_private_subnet_2d_association" {
  subnet_id = aws_subnet.bmo_private_subnet_2d.id
  route_table_id = aws_route_table.bmo_private_rtb.id
}

resource "aws_route_table" "bmo_private_rtb" {
  vpc_id = aws_vpc.bmo_vpc.id
  tags = {
    Name = "BMO-PRIVATE-SUBNET-RTB"
  }
}
