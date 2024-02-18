
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "26. Step-02: Input Variables Introduction."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 26. Step-02: Input Variables Introduction

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





# ############################################################################
# ############################################################################
# ############################################################################
# 26. Step-02: Input Variables Introduction

Step-00: Introduction

    v1: Input Variables - Basics
    v2: Provide Input Variables when prompted during terraform plan or apply
    v3: Override default variable values using CLI argument -var
    v4: Override default variable values using Environment Variables
    v5: Provide Input Variables using terraform.tfvars files
    v6: Provide Input Variables using <any-name>.tfvars file with CLI argument -var-file
    v7: Provide Input Variables using auto.tfvars files
    v8-01: Implement complex type constructors like list
    v8-02: Implement complex type constructors like maps
    v9: Implement Custom Validation Rules in Variables
    v10: Protect Sensitive Input Variables
    v11: Understand about File function
