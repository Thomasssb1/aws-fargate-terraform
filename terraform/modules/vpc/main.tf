resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gw"
  }
}

locals {
  availability_zone_a = "${var.availability_zone}a"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = local.availability_zone_a

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
  map_public_ip_on_launch = false
  availability_zone       = local.availability_zone_a

  tags = {
    Name = "subnet2"
  }
}

resource "aws_eip" "eip_ngw" {
  count = 1
}

resource "aws_nat_gateway" "ngw" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public.id
  allocation_id     = aws_eip.eip_ngw[0].id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-outgoing-rt"
  }
}

resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-ingoing-outgoing-rt"
  }
}

resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}