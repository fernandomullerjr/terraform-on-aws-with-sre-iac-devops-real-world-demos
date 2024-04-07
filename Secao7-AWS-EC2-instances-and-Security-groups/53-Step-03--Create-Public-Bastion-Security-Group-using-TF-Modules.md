
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "53. Step-03: Create Public Bastion Security Group using TF Modules."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 53. Step-03: Create Public Bastion Security Group using TF Modules

## Step-04: Create Security Groups for Bastion Host and Private Subnet Hosts
### Step-04-01: c5-01-securitygroup-variables.tf
- Place holder file for defining any Input Variables for EC2 Security Groups

### Step-04-02: c5-03-securitygroup-bastionsg.tf
- [SG Module Examples for Reference](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/examples/complete)

```tf
# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "public-bastion-sg"
  description = "Security group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Block  
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags  
}
```





# ############################################################################
# ############################################################################
# ############################################################################
# 53. Step-03: Create Public Bastion Security Group using TF Modules

- Usar o módulo security-group - "AWS EC2-VPC Security Group Terraform module"
<https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest>


- Criando o módulo para a SG do Bastion

~~~~tf
# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  #version = "3.18.0"
  version = "5.1.0"

  name = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

~~~~