
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "45. Step-04: Create Basic VPC Module."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 45. Step-04: Create Basic VPC Module

### Step-02-02: Create a VPC Module Terraform Configuration 

<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/06-AWS-VPC/06-02-AWS-VPC-using-Terraform>

- c1-versions.tf
- c2-generic-variables.tf
- c3-vpc.tf
- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

```tf
# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"   
  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  #create_database_nat_gateway_route = true
  #create_database_internet_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner = "kalyan"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}
```







# ############################################################################
# ############################################################################
# ############################################################################
# 45. Step-04: Create Basic VPC Module


- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)


- Ao declarar o nome "vpc", é personalizável, poderia ser module "myvpc", por exemplo:

~~~~tf
module "myvpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"
}
~~~~






# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Diferença entre bloco Terraform e argumentos.

## Bloco Terraform

terraform {

}

## Argumento

tem o sinal de igual antes das chaves

  public_subnet_tags = {
    Type = "public-subnets"
  }
