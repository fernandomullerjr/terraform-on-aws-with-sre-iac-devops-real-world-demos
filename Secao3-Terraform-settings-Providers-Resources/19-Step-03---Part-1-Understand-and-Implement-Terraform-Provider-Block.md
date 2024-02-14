
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "19. Step-03: Part-1: Understand and Implement Terraform Provider Block."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 19. Step-03: Part-1: Understand and Implement Terraform Provider Block

Step-03: In c1-versions.tf - Create Terraform Providers Block

    Understand about Terraform Providers
    Configure AWS Credentials in the AWS CLI if not configured

# Verify AWS Credentials
cat $HOME/.aws/credentials

    Create AWS Providers Block

# Provider Block
provider "aws" {
  region  = us-east-1
  profile = "default"
}




- O Terraform Provider setado no Terraform Block é baixado do Terraform Registry.



~~~~tf
terraform {
  required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
~~~~


Este nome "aws" é um nome que pode ser personalizado.
Este "Local name" é usado como aws normalmente.


## PENDENTE
- Continua em
08:40h
- Ver sobre versões, que quebra ou não, minor version.