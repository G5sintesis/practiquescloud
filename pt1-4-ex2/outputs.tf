###############################################################################
# Pt1.4 - Exercici 2: Valors de sortida (Outputs)
# Alumne: David Cortés Fontana (ASIX2 - INS Provençana)
###############################################################################

output "vpc_id" {
  description = "Identificador de la VPC principal creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloc CIDR assignat a la VPC principal"
  value       = aws_vpc.main.cidr_block
}

output "subnets_info" {
  description = "Detall de les 3 subxarxes desplegades a us-east-1a"
  value = {
    for k, s in aws_subnet.subnets :
    k => {
      subnet_id         = s.id
      name              = s.tags["Name"]
      cidr_block        = s.cidr_block
      availability_zone = s.availability_zone
    }
  }
}

output "ec2_instances_info" {
  description = "Detall de les 6 instàncies EC2 desplegades (2 per subxarxa)"
  value = {
    for k, inst in aws_instance.nodes :
    k => {
      instance_id   = inst.id
      name          = inst.tags["Name"]
      instance_type = inst.instance_type
      subnet_id     = inst.subnet_id
      private_ip    = inst.private_ip
      state         = inst.instance_state
    }
  }
}
