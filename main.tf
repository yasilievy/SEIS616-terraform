
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = "us-west-2"
}

provider "random" {}

resource "random_pet" "name" {}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "education"
  cidr                 = "10.0.0.0/16"
  azs                  = var.vpc_azs
  public_subnets       = var.vpc_public_subnets
  private_subnets      = var.vpc_private_subnets
  enable_dns_hostnames = true
  enable_dns_support   = true
}



resource "aws_security_group" "rds" {
  name   = "infrastructure_rds"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "infrastructure_rds"
  }
}

resource "aws_db_parameter_group" "infrastructure" {
  name   = "infrastructure"
  family = "mysql"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "infrastructure" {
  name       = "infrastructure"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "Infrastructure"
  }
}

resource "aws_db_instance" "infrastructure" {
  identifier             = "infrastructure"
  instance_class         = "db.t3.micro"
  engine                 = "mysql"
  username               = "infra"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.infrastructure.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

resource "aws_instance1" "instance1_name" {
  ami           = "ami-a0cfeed8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = random_pet.name.id
  }
}

resource "aws_instance2" "instance2_name" {
  ami           = "ami-a0cfeed8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = random_pet.name.id
  }
}