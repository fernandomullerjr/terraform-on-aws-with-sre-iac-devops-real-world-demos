
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "17. Step-01: Introduction to Terraform Settings, Providers and Resources."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 17. Step-01: Introduction to Terraform Settings, Providers and Resources

Terraform Settings, Providers & Resource Blocks
Step-01: Introduction

    Terraform Settings
    Terraform Providers
    Terraform Resources
    Terraform File Function
    Create EC2 Instance using Terraform and provision a webserver with userdata.


## Provisioners
<https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax>
Provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction. 
Provisioners can be used to bootstrap a resource, cleanup before destroy, run configuration management, etc.


c1-versions.tf

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = "us-east-1"
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
~~~~