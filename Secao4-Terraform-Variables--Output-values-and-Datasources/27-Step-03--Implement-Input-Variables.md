
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "27. Step-03: Implement Input Variables."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 27. Step-03: Implement Input Variables

## Step-02: c2-variables.tf - Define Input Variables in Terraform
- [Terraform Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [Terraform Input Variable Usage - 10 different types](https://github.com/stacksimplify/hashicorp-certified-terraform-associate/tree/main/05-Terraform-Variables/05-01-Terraform-Input-Variables)

```t
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

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
- Reference the variables in respective `.tf`fies
```t
# c1-versions.tf
region  = var.aws_region

# c5-ec2instance.tf
instance_type = var.instance_type
key_name = var.instance_keypair  
```






- Editando o versions, colocando a região usando variável:

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = var.aws_region
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
~~~~



- aJUSTANDO VARIÁVEL
"t2.micro"