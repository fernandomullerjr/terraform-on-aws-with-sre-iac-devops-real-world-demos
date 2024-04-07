
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "55. Step-05: Create EC2 Instance Variables and Public Bastion Instance."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 55. Step-05: Create EC2 Instance Variables and Public Bastion Instance

## Step-05: c6-01-datasource-ami.tf

```tf
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
```


## Step-06: EC2 Instances
### Step-06-01: c7-01-ec2instance-variables.tf

```tf
# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}
```


### Step-06-02: c7-03-ec2instance-bastion.tf
- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)
```t
# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variables here
  name = "${var.environment}-BastionHost"
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  key_name = var.instance_keypair
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]    
  tags = local.common_tags
}
```


### Step-06-03: c7-04-ec2instance-private.tf
- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)
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


### Step-06-04: c7-02-ec2instance-outputs.tf
```tf
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
# 55. Step-05: Create EC2 Instance Variables and Public Bastion Instance

- Vamos criar a EC2 do Bastion, numa subnet pública.
- Exemplo do repositório do curso está defasado.
- Importante, devido burst da t3a.micro "unlimited", utilizar t2 no lugar.
- Ajustando os novos manifestos de variables para o código atualizado, que tem o "private_instance_count":

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c7-01-ec2instance-variables.tf

~~~~tf
# AWS EC2 Instance Terraform Variables
# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "AWS EC2 Private Instances Count"
  type = number
  default = 1  
}
~~~~



- Vamos utilizar o módulo EC2 para criar as EC2
<https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest>

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c7-03-ec2instance-bastion.tf

~~~~TF
# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.6.0"
  # insert the 10 required variables here
  name                   = "${var.environment}-BastionHost"
  #instance_count         = 5
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  #vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags = local.common_tags
}
~~~~





# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO / IMPORTANTE

- Importante, devido burst da t3a.micro "unlimited", utilizar t2 no lugar.