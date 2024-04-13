
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "56. Step-06-01: Create Private EC2 Instance Module."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
# 56. Step-06-01: Create Private EC2 Instance Module

### Step-06-03: c7-04-ec2instance-private.tf

- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)

```t
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  name = "${var.environment}-vm"
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/apache-install.sh")
  key_name = var.instance_keypair
  #subnet_id = module.vpc.private_subnets[0] # Single Instance
  vpc_security_group_ids = [module.private_sg.this_security_group_id]    
  instance_count = 3
  subnet_ids = [
    module.vpc.private_subnets[0], 
    module.vpc.private_subnets[1],
    ]
  tags = local.common_tags
}
```

### Step-06-04: c7-02-ec2instance-outputs.tf

```t
# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}
output "ec2_bastion_public_ip" {
  description = "List of Public ip address assigned to the instances"
  value       = module.ec2_public.public_ip
}
# Private EC2 Instances
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private.id
}
output "ec2_private_ip" {
  description = "List of private ip address assigned to the instances"
  value       = module.ec2_private.private_ip
}
```






# ############################################################################
# ############################################################################
# ############################################################################
# 56. Step-06-01: Create Private EC2 Instance Module

- Na aula é utilizado o manifesto na versão antiga "2.17.0":

```tf
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  name = "${var.environment}-vm"
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/apache-install.sh")
  key_name = var.instance_keypair
  #subnet_id = module.vpc.private_subnets[0] # Single Instance
  vpc_security_group_ids = [module.private_sg.this_security_group_id]    
  instance_count = 3
  subnet_ids = [
    module.vpc.private_subnets[0], 
    module.vpc.private_subnets[1],
    ]
  tags = local.common_tags
}
```




## The depends_on Meta-Argument

<https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on>

Use the depends_on meta-argument to handle hidden resource or module dependencies that Terraform cannot automatically infer.





- Como usamos uma EC2 privada neste caso
e esta EC2 utiliza user_data para instalar o httpd
ela vai precisar usar o NAT Gateway
porém o NAT Gateway pode levar algum tempo até ser provisionado
então é necessário utilizar:
depends_on = [ module.vpc ]



- Manifesto coletado do zip:

~~~~tf
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.6.0"
  # insert the 10 required variables here
  name                   = "${var.environment}-vm"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags


# BELOW CODE COMMENTED AS PART OF MODULE UPGRADE TO 5.5.0
  #vpc_security_group_ids = [module.private_sg.this_security_group_id]    
  #instance_count         = var.private_instance_count
  #subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1] ]

# Changes as of Module version UPGRADE from 2.17.0 to 5.5.0
  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
}


# ELEMENT Function
# terraform console 
# element(["kalyan", "reddy", "daida"], 0)
# element(["kalyan", "reddy", "daida"], 1)
# element(["kalyan", "reddy", "daida"], 2)
~~~~







# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO / IMPORTANTE

- Use the depends_on meta-argument to handle hidden resource or module dependencies that Terraform cannot automatically infer.

- Como usamos uma EC2 privada neste caso, e esta EC2 utiliza user_data para instalar o httpd, ela vai precisar usar o NAT Gateway. Então é necessário utilizar o Meta-argument "depends_on":
depends_on = [ module.vpc ]