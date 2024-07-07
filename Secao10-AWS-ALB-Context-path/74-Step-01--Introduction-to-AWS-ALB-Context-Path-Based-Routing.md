
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "74. Step-01: Introduction to AWS ALB Context Path Based Routing."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  74. Step-01: Introduction to AWS ALB Context Path Based Routing

# AWS ALB Context Path based Routing using Terraform

## Step-00: Pre-requisites
- You need a Registered Domain in AWS Route53 to implement this usecase
- Lets discuss more about it
- Go to AWS Services -> Route53 -> Domains -> Registered Domains -> Register Domain
- Choose a domain name: abcabc.com and click on **Check** 
- If available, click on **Add to Cart** and Click on **Continue**
- Provide `Contact Details for Your 1 Domain` and Click on **Continue**
- Terms and Conditions: Check and click on **Complete Order**
- Go back to **Billing** and complete the payment for the domain to be approved
- Copy your `terraform-key.pem` file to `terraform-manifests/private-key` folder

## Step-01: Introduction
- We are going to implement Context Path based Routing in AWS Application Load Balancer using Terraform.
- To achieve that we are going to implement many series of steps. 
- We are going to implement the following using AWS ALB 
1. Fixed Response for /* : http://apps.devopsincloud.com   
2. App1 /app1* goes to App1 EC2 Instances: http://apps.devopsincloud.com/app1/index.html
3. App2 /app2* goes to App2 EC2 Instances: http://apps.devopsincloud.com/app2/index.html
4. HTTP to HTTPS Redirect

## Step-02: Copy all files from previous section 
- We are going to copy all files from previous section `09-AWS-ALB-Application-LoadBalancer-Basic`
- Files from `c1 to c10`
- Create new files
  - c6-02-datasource-route53-zone.tf
  - c11-acm-certificatemanager.tf
  - c12-route53-dnsregistration.tf
- Review the files
  - app1-install.sh
  - app2-install.sh  

 