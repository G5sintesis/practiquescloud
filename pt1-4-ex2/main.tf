###############################################################################
# Pt1.4 - Exercici 2: Disseny i Desplegament de VPC, Subxarxes i EC2 (IaC)
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
#
# Especificacions de xarxa i còmput:
#   - VPC Principal : 10.0.0.0/16
#   - Subnet A      : 10.0.32.0/25 (us-east-1a) -> 2x EC2 t3.micro (AL2023)
#   - Subnet B      : 10.0.30.0/23 (us-east-1a) -> 2x EC2 t3.micro (AL2023)
#   - Subnet C      : 10.0.33.0/28 (us-east-1a) -> 2x EC2 t3.micro (AL2023)
#   - Total EC2     : 6 instàncies t3.micro amb Amazon Linux 2023
###############################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "practiquescloud"
      Exercise  = var.project_name
      Author    = "David Cortes Fontana"
      Course    = "ASIX2-CloudComputing"
      ManagedBy = "Terraform"
    }
  }
}

# -----------------------------------------------------------------------------
# Obtenció dinàmica de l'AMI oficial més recent d'Amazon Linux 2023 (x86_64)
# -----------------------------------------------------------------------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# -----------------------------------------------------------------------------
# Creació de la VPC personalitzada (10.0.0.0/16)
# -----------------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# -----------------------------------------------------------------------------
# Creació de les 3 subxarxes a la Zona de Disponibilitat us-east-1a (AZ-1A)
# -----------------------------------------------------------------------------
resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = var.availability_zone

  tags = {
    Name       = "${var.project_name}-${each.value.name}"
    SubnetCode = each.key
  }
}

# -----------------------------------------------------------------------------
# Generació dinàmica de les 6 instàncies EC2 (2 per cada subxarxa A, B i C)
# -----------------------------------------------------------------------------
locals {
  ec2_matrix = merge([
    for subnet_key, subnet_cfg in var.subnets : {
      for idx in range(var.instances_per_subnet) :
      "${subnet_key}-${idx + 1}" => {
        subnet_key  = subnet_key
        subnet_name = subnet_cfg.name
        index       = idx + 1
      }
    }
  ]...)
}

resource "aws_instance" "nodes" {
  for_each = local.ec2_matrix

  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnets[each.value.subnet_key].id

  tags = {
    Name   = "${var.project_name}-ec2-subnet-${each.key}"
    Subnet = each.value.subnet_name
  }
}
