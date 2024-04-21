
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "66. Step-03: Create CLB Outputs, Execute TF Commands and Test."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  66. Step-03: Create CLB Outputs, Execute TF Commands and Test 

### Step-04-02: Outputs for ELB Classic Load Balancer

- [Refer Outputs from Example](https://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest/examples/complete)
- c10-03-ELB-classic-loadbalancer-outputs.tf

```tf
# Terraform AWS Classic Load Balancer (ELB-CLB) Outputs
output "elb_id" {
  description = "The name of the ELB"
  value       = module.elb.elb_id
}

output "elb_name" {
  description = "The name of the ELB"
  value       = module.elb.elb_name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = module.elb.elb_dns_name
}

output "elb_instances" {
  description = "The list of instances in the ELB (if may be outdated, because instances are attached using elb_attachment resource)"
  value       = module.elb.elb_instances
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances"
  value       = module.elb.elb_source_security_group_id
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = module.elb.elb_zone_id
}
```


## Step-05: Execute Terraform Commands

```t
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
3. Verify Load Balancer Instances are healthy
4. Access sample app using Load Balancer DNS Name
5. Access Sample app with port 81 using Load Balancer DNS Name, it should fail, because from loadbalancer_sg port 81 is not allowed from internet. 
# Example: from my environment
http://HR-stag-myelb-557211422.us-east-1.elb.amazonaws.com  - Will pass
http://HR-stag-myelb-557211422.us-east-1.elb.amazonaws.com:81  - will fail
```


## Step-06: Update c5-05-securitygroup-loadbalancersg.tf 

```t
  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow Port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ] 
```

## Step-07: Again Execute Terraform Commands

```t
# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify
Observation: 
1) Verify loadbalancer-sg in AWS mgmt console
2) Access App using port 81 and test
http://HR-stag-myelb-557211422.us-east-1.elb.amazonaws.com:81  - should pass
```


## Step-08: Clean-Up

```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```






# ############################################################################
# ############################################################################
# ############################################################################
#  66. Step-03: Create CLB Outputs, Execute TF Commands and Test 


- Copiado do zip

~~~~tf
# Terraform AWS Classic Load Balancer (ELB-CLB) Outputs
output "elb_id" {
  description = "The name of the ELB"
  value       = module.elb.elb_id
}

output "elb_name" {
  description = "The name of the ELB"
  value       = module.elb.elb_name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = module.elb.elb_dns_name
}

output "elb_instances" {
  description = "The list of instances in the ELB (if may be outdated, because instances are attached using elb_attachment resource)"
  value       = module.elb.elb_instances
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances"
  value       = module.elb.elb_source_security_group_id
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = module.elb.elb_zone_id
}
~~~~