
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "54. Step-04: Create Private Security Group and Outputs for both SG's NEW."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 54. Step-04: Create Private Security Group and Outputs for both SG's NEW


### Step-04-03: c5-04-securitygroup-privatesg.tf

```tf
# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "private-sg"
  description = "Security group with HTTP & SSH ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  tags = local.common_tags  
}
```


- Criando o manifesto
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c5-04-securitygroup-privatesg.tf


- No manifesto no repositório do curso e no exemplo do README deles, consta o bloco CIDR "0.0.0.0/0"
- Porém, o correto é liberar apenas o bloco da VPC.

- Ajustando, colocando "module.vpc.vpc_cidr_block" no ingress_cidr_blocks:

```tf
# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  #version = "3.18.0"
  version = "5.1.0"

  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
```





### Outputs

- Para criar os outputs, iremos nos basear no código de exemplo do módulo.
- Pegando o exemplo completo:
https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/v5.1.2/examples/complete/outputs.tf

~~~~tf
output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.complete_sg.security_group_arn
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.complete_sg.security_group_id
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.complete_sg.security_group_vpc_id
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = module.complete_sg.security_group_owner_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.complete_sg.security_group_name
}

output "security_group_description" {
  description = "The description of the security group"
  value       = module.complete_sg.security_group_description
}
~~~~



- Iremos adaptar o código
onde tem module.complete_sg
ajustar conforme o nome dos módulos que foram criados no projeto:
module.public_bastion_sg.xyz
module.private_sg.xyz

- Código dos outputs contendo os valores mais importantes que precisamos de cada módulo:

~~~~tf
# AWS EC2 Security Group Terraform Outputs

# Public Bastion Host Security Group Outputs
## public_bastion_sg_group_id
output "public_bastion_sg_group_id" {
  description = "The ID of the security group"
  #value       = module.public_bastion_sg.this_security_group_id
  value       = module.public_bastion_sg.security_group_id
}

## public_bastion_sg_group_vpc_id
output "public_bastion_sg_group_vpc_id" {
  description = "The VPC ID"
  # value       = module.public_bastion_sg.this_security_group_vpc_id
  value       = module.public_bastion_sg.security_group_vpc_id
}

## public_bastion_sg_group_name
output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  #value       = module.public_bastion_sg.this_security_group_name
  value       = module.public_bastion_sg.security_group_name
}

# Private EC2 Instances Security Group Outputs
## private_sg_group_id
output "private_sg_group_id" {
  description = "The ID of the security group"
  #value       = module.private_sg.this_security_group_id
  value       = module.private_sg.security_group_id
}

## private_sg_group_vpc_id
output "private_sg_group_vpc_id" {
  description = "The VPC ID"
  #value       = module.private_sg.this_security_group_vpc_id
  value       = module.private_sg.security_group_vpc_id
}

## private_sg_group_name
output "private_sg_group_name" {
  description = "The name of the security group"
  #value       = module.private_sg.this_security_group_name
  value       = module.private_sg.security_group_name
}
~~~~




- Ajustar a versão dos módulos utilizados
- Utilizar a versão mais recente da época do video/curso:
  version = "5.1.0"


