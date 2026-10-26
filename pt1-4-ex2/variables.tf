###############################################################################
# Pt1.4 - Exercici 2: Variables de configuració (VPC, Subnets i EC2)
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
###############################################################################

variable "aws_region" {
  description = "Regió d'AWS on es desplega tota la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Zona de disponibilitat única per a les 3 subxarxes (AZ-1A)"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "Bloc CIDR de la VPC personalitzada principal"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El bloc CIDR de la VPC ha de tenir un format vàlid (ex: 10.0.0.0/16)."
  }
}

variable "subnets" {
  description = "Definició de les 3 subxarxes (Subnet A, Subnet B i Subnet C) amb els seus blocs CIDR"
  type = map(object({
    name = string
    cidr = string
  }))

  default = {
    A = {
      name = "Subnet-A"
      cidr = "10.0.32.0/25"
    }
    B = {
      name = "Subnet-B"
      cidr = "10.0.30.0/23"
    }
    C = {
      name = "Subnet-C"
      cidr = "10.0.33.0/28"
    }
  }

  validation {
    condition     = length(var.subnets) == 3
    error_message = "S'han de definir exactament les 3 subxarxes sol·licitades (A, B i C)."
  }
}

variable "instance_type" {
  description = "Tipus d'instància EC2 a desplegar a cada subxarxa"
  type        = string
  default     = "t3.micro"
}

variable "instances_per_subnet" {
  description = "Nombre d'instàncies EC2 a desplegar dins de cadascuna de les subxarxes"
  type        = number
  default     = 2

  validation {
    condition     = var.instances_per_subnet >= 1
    error_message = "Cal desplegar com a mínim 1 instància per subxarxa."
  }
}

variable "project_name" {
  description = "Nom identificatiu del projecte utilitzat a les etiquetes (Tags)"
  type        = string
  default     = "pt1-4-ex2"
}
