resource "aws_vpc" "tuyojr-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "tuyojr-vpc"
  }
}

resource "aws_subnet" "public_subnets_1" {
  vpc_id            = aws_vpc.tuyojr-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.azs
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_internet_gateway" "tuyojr-igw" {
  vpc_id = aws_vpc.tuyojr-vpc.id
  tags = {
    Name = "tuyojr-igw"
  }
}

resource "aws_default_route_table" "tuyojr-rtb" {
  default_route_table_id = aws_vpc.tuyojr-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tuyojr-igw.id
  }
  tags = {
    Name = "tuyojr-rtb"
  }
}

resource "aws_security_group" "jenkins-sg" {
    name        = "jenkins-sg"
    description = "Security group for Jenkins"
    vpc_id      = aws_vpc.tuyojr-vpc.id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8081
        to_port     = 8083
        description = "Ports to receive traffic from Prometheus and Grafana"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "jenkins-sg"
    }
}