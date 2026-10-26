###############################################################################
# Pt1.4 - Exercici 1: Primeres instàncies EC2 amb Terraform
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
#
# Descripció:
#   Desplegament automatitzat de 2 instàncies EC2 (t3.micro) amb sistema
#   operatiu Amazon Linux 2023 a la regió us-east-1 dins de la VPC per defecte.
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
# Consulta de la VPC per defecte i la subxarxa de la zona us-east-1a
# -----------------------------------------------------------------------------
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default_az" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = var.availability_zone
  default_for_az    = true
}

# -----------------------------------------------------------------------------
# Creació de les 2 instàncies EC2 (t3.micro - Amazon Linux 2023)
# -----------------------------------------------------------------------------
resource "aws_instance" "ec2_nodes" {
  count = var.instance_count

  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.default_az.id
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-ec2-0${count.index + 1}"
  }
}
