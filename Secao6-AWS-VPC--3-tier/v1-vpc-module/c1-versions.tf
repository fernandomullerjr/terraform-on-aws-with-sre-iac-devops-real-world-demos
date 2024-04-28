# Terraform Block
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region

  profile = "fernandomullerjunior-labs/AdministratorAccess"

  assume_role {
    role_arn = "arn:aws:iam::058264180843:role/admin-role-account-sandbox"
    # (Optional) The external ID created in step 1c.
    external_id  = "7755"
    session_name = "terraform-session"
  }

}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
