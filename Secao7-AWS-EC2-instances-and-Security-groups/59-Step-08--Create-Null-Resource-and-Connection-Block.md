
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "59. Step-08: Create Null Resource and Connection Block."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  59. Step-08: Create Null Resource and Connection Block

## Step-08: c9-nullresource-provisioners.tf

### Step-08-01: Define null resource in c1-versions.tf

- Learn about [Terraform Null Resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- Define null resource in c1-versions.tf in `terraform block`

```tf
    null = {
      source = "hashicorp/null"
      version = "~> 3.0.0"
    }    
```




- Ajustar o arquivo c1-versions.tf
incluir o provider null

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c1-versions.tf

código ajustado:

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

~~~~