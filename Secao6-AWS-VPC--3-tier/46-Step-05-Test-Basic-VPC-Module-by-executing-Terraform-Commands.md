
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "46. Step-05: Test Basic VPC Module by executing Terraform Commands."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 46. Step-05: Test Basic VPC Module by executing Terraform Commands


## Step-03: Execute Terraform Commands

```bash
# Working Folder
terraform-manifests/v1-vpc-module

# Terraform Initialize
terraform init
Observation:
1. Verify if modules got downloaded to .terraform folder

# Terraform Validate
terraform validate

# Terraform plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
Observation:
1) Verify VPC
2) Verify Subnets
3) Verify IGW
4) Verify Public Route for Public Subnets
5) Verify no public route for private subnets
6) Verify NAT Gateway and Elastic IP for NAT Gateway
7) Verify NAT Gateway route for Private Subnets
8) Verify no public route or no NAT Gateway route to Database Subnets
9) Verify Tags

# Terraform Destroy
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```