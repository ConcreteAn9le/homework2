###########################
# EC2 + VPC pair1
###########################
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags                 = {
    Name = "vpcA"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "subnetA"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "igwA"
  }
}

resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "route_tableA"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "instanceA"
  }
}
###########################
# EC2 + VPC pair2
###########################
resource "aws_vpc" "vpc2" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags                 = {
    Name = "vpcB"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "192.168.0.0/16"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "subnetB"
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "igwB"
  }
}

resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_internet_gateway.igw2.id
  }

  tags = {
    Name = "route_tableB"
  }
}

resource "aws_instance" "instance2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "instanceB"
  }
}

################
# VPC Peering
################
resource "aws_vpc_peering_connection" "vpc1_to_vpc2" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
  tags = {
    Name = "vpcA-to-vpcB"
  }
}