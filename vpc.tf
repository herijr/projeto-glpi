resource "aws_vpc" "this" {
  enable_dns_hostnames = true
  enable_dns_support   = true

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project-name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project-name}-igw"
  }
}

resource "aws_subnet" "public01" {
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "${var.project-name}-publica01a"
  }
}

resource "aws_subnet" "public02" {
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "${var.aws_region}b"
  tags = {
    Name = "${var.project-name}-publica02b"
  }
}

resource "aws_subnet" "public03" {
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.13.0/24"
  availability_zone       = "${var.aws_region}c"
  tags = {
    Name = "${var.project-name}-publica03c"
  }
}

resource "aws_subnet" "private01" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "${var.project-name}-privada01a"
  }
}

resource "aws_subnet" "private02" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "${var.project-name}-privada02b"
  }
}

resource "aws_subnet" "private03" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}c"
  tags = {
    Name = "${var.project-name}-privada03c"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.project-name}-public_rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project-name}-private_rt01"
  }
}

resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.public01.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.public02.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub03" {
  subnet_id      = aws_subnet.public03.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pvt01" {
  subnet_id      = aws_subnet.private01.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "pvt02" {
  subnet_id      = aws_subnet.private02.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "pvt03" {
  subnet_id      = aws_subnet.private03.id
  route_table_id = aws_route_table.private.id
}