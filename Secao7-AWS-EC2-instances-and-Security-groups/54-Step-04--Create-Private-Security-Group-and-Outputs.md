
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