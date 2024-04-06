
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "50. Step-09: VPC Module - Define Variables, Reference Variables in Module and Define."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 50. Step-09: VPC Module - Define Variables, Reference Variables in Module and Define


## Step-07: c4-01-vpc-variables.tf

```tf
# VPC Input Variables

# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "myvpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type = list(string)
  default = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type = bool
  default = true 
}

# VPC Create Database Subnet Route Table (True or False)
variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type = bool
  default = true   
}

  
# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type = bool
  default = true  
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type = bool
  default = true
}
```




## Step-08: c4-02-vpc-module.tf

```tf
# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  #version = "2.78.0"
  #version = "~> 2.78"
  version = "5.2.0"  

  # VPC Basic Details
  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets  

  # Database Subnets
  database_subnets = var.vpc_database_subnets
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route = true
  
  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway 
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }
  private_subnet_tags = {
    Type = "Private Subnets"
  }  
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }
}
```



## Step-09: c4-03-vpc-outputs.tf

```tf
# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}
```




# ############################################################################
# ############################################################################
# ############################################################################
# 50. Step-09: VPC Module - Define Variables, Reference Variables in Module and Define

- É importante reforçar que para poder referenciar um projeto em outro diferente, através das informações do seu Statefile, é necessário que no projeto a ser referenciado as informações tenham sido fornecidas nos Outputs.



- Sobre as variaveis no arquivo "vpc.auto.tfvars":
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized/vpc.auto.tfvars

~~~~bash
# VPC Variables
vpc_name = "myvpc"
vpc_cidr_block = "10.0.0.0/16"
vpc_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_database_subnets= ["10.0.151.0/24", "10.0.152.0/24"]
vpc_create_database_subnet_group = true 
vpc_create_database_subnet_route_table = true   
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true
~~~~


- Porque usar estas variaveis do "vpc.auto.tfvars", se temos as "terraform.tfvars", também temos as variáveis da VPC, inputs, outputs, entre outros?

Por exemplo, temos as "terraform.tfvars" contendo variáveis mais genéricas/universais ao projeto:

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized/terraform.tfvars

~~~~bash
# Generic Variables
aws_region = "us-east-1"
environment = "stag"
business_divsion = "HR"
~~~~


- Já no arquivo "vpc.auto.tfvars", temos variáveis mais especificas e relacionadas somente a VPC.
- Faz sentido utilizar variaveis como "vpc.auto.tfvars" e outros arquivos "*.auto.tfvars" em situações onde temos muitas variáveis e não queremos ter um arquivo de variáveis de dificil manutenção, muito extenso e etc.

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized/vpc.auto.tfvars

~~~~bash
# VPC Variables
vpc_name = "myvpc"
vpc_cidr_block = "10.0.0.0/16"
vpc_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_database_subnets= ["10.0.151.0/24", "10.0.152.0/24"]
vpc_create_database_subnet_group = true 
vpc_create_database_subnet_route_table = true   
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true
~~~~



# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- É importante reforçar que para poder referenciar um projeto em outro diferente, através das informações do seu Statefile, é necessário que no projeto a ser referenciado as informações tenham sido fornecidas nos Outputs.

- Faz sentido utilizar variaveis como "vpc.auto.tfvars" e outros arquivos "*.auto.tfvars" em situações onde temos muitas variáveis e não queremos ter um arquivo de variáveis de dificil manutenção, muito extenso e etc.