###############################################################################
# Pt1.4 - Exercici 1: Variables de configuració
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
###############################################################################

variable "aws_region" {
  description = "Regió d'AWS on es desplegaran les instàncies EC2"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Zona de disponibilitat dins de la regió seleccionada"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "Tipus d'instància EC2 sol·licitat a l'enunciat"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Nombre total d'instàncies EC2 a desplegar"
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 1
    error_message = "El nombre d'instàncies ha de ser com a mínim 1."
  }
}

variable "project_name" {
  description = "Nom identificatiu del projecte per a l'etiquetatge de recursos"
  type        = string
  default     = "pt1-4-ex1"
}
