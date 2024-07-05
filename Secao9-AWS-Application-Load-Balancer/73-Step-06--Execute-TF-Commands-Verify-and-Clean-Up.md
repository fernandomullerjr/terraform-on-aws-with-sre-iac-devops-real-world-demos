
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "73. Step-06: Execute TF Commands, Verify and Clean-Up."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#   73. Step-06: Execute TF Commands, Verify and Clean-Up


## Step-06: Execute Terraform Commands
```bash
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify
Observation: 
1. Verify EC2 Instances
2. Verify Load Balancer SG
3. Verify ALB Listeners and Rules
4. Verify ALB Target Groups, Targets (should be healthy) and Health Check settings
5. Access sample app using Load Balancer DNS Name
# Example: from my environment
http://hr-stag-alb-1575108738.us-east-1.elb.amazonaws.com 
http://hr-stag-alb-1575108738.us-east-1.elb.amazonaws.com/app1/index.html
http://hr-stag-alb-1575108738.us-east-1.elb.amazonaws.com/app1/metadata.html
```

## Step-07: Clean-Up
```bash
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```





# ############################################################################
# ############################################################################
# ############################################################################
#   73. Step-06: Execute TF Commands, Verify and Clean-Up


- Validando:

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$
~~~~


- Verificando:

~~~~json

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ curl sap-dev-alb-336877393.us-east-1.elb.amazonaws.com/app1/metadata.html | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   474  100   474    0     0   1538      0 --:--:-- --:--:-- --:--:--  1543
{
  "accountId": "058264180843",
  "architecture": "x86_64",
  "availabilityZone": "us-east-1b",
  "billingProducts": null,
  "devpayProductCodes": null,
  "marketplaceProductCodes": null,
  "imageId": "ami-0241b1d769b029352",
  "instanceId": "i-0ddd031f6c2ed4b4d",
  "instanceType": "t2.micro",
  "kernelId": null,
  "pendingTime": "2024-07-05T03:10:52Z",
  "privateIp": "10.0.2.225",
  "ramdiskId": null,
  "region": "us-east-1",
  "version": "2017-09-30"
}
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$

~~~~


## Step-07: Clean-Up
```bash
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```