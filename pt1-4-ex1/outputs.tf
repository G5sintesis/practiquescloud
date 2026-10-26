###############################################################################
# Pt1.4 - Exercici 1: Valors de sortida (Outputs)
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
###############################################################################

output "ami_id" {
  description = "Identificador de l'AMI d'Amazon Linux 2023 utilitzada"
  value       = data.aws_ami.amazon_linux_2023.id
}

output "default_vpc_id" {
  description = "ID de la VPC per defecte on s'han desplegat les instàncies"
  value       = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "ID de la subxarxa utilitzada a la zona de disponibilitat"
  value       = data.aws_subnet.default_az.id
}

output "instances_summary" {
  description = "Resum detallat de les 2 instàncies EC2 desplegades"
  value = {
    for idx, instance in aws_instance.ec2_nodes :
    instance.tags["Name"] => {
      id                = instance.id
      instance_type     = instance.instance_type
      availability_zone = instance.availability_zone
      private_ip        = instance.private_ip
      public_ip         = instance.public_ip
    }
  }
}
