
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "64. Step-01: Introduction to AWS Classic Load Balancer."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  64. Step-01: Introduction to AWS Classic Load Balancer

# AWS Classic Load Balancer with Terraform

## Step-01: Introduction
- Create AWS Security Group module for ELB CLB Load Balancer
- Create AWS ELB Classic Load Balancer Terraform Module
- Define Outputs for Load Balancer
- Access and test
- [Terraform Module AWS ELB](https://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest) used


## Step-02: Copy all templates from previous section 
- Copy `terraform-manifests` folder from `07-AWS-EC2Instance-and-SecurityGroups`
- We will add four more files in addition to previous section `07-AWS-EC2Instance-and-SecurityGroups`
- c5-05-securitygroup-loadbalancersg.tf
- c10-01-ELB-classic-loadbalancer-variables.tf
- c10-02-ELB-classic-loadbalancer.tf
- c10-03-ELB-classic-loadbalancer-outputs.tf