
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "62. Step-11: Execute Terraform Commands."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  62. Step-11: Execute Terraform Commands


## Step-11: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
Observation: 
1) Review Security Group resources 
2) Review EC2 Instance resources
3) Review all other resources (vpc, elasticip) 

# Terraform Apply
terraform apply -auto-approve
Observation:
1) VERY IMPORTANT: Primarily observe that first VPC NAT Gateway will be created and after that only module.ec2_private related EC2 Instance will be created
```




~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos$ terraform apply -auto-approve

module.ec2_private["0"].aws_instance.this[0]: Still creating... [20s elapsed]
module.ec2_private["1"].aws_instance.this[0]: Still creating... [20s elapsed]
module.ec2_private["1"].aws_instance.this[0]: Creation complete after 26s [id=i-0a79e9e3765dc238e]
module.ec2_private["0"].aws_instance.this[0]: Still creating... [30s elapsed]
module.ec2_private["0"].aws_instance.this[0]: Still creating... [40s elapsed]
module.ec2_private["0"].aws_instance.this[0]: Creation complete after 46s [id=i-01abd69748d326092]

Apply complete! Resources: 37 added, 0 changed, 0 destroyed.

Outputs:

azs = tolist([
  "us-east-1a",
  "us-east-1b",
])
ec2_bastion_public_instance_ids = "i-05705c9d087c2a81d"
ec2_bastion_public_ip = ""
ec2_private_instance_ids = [
  "i-01abd69748d326092",
  "i-0a79e9e3765dc238e",
]
ec2_private_ip = [
  "10.0.1.22",
  "10.0.2.172",
]
nat_public_ips = tolist([
  "44.223.163.236",
])
private_sg_group_id = "sg-0fd354d93b0d12bdf"
private_sg_group_name = "private-sg-20240420145546442400000001"
private_sg_group_vpc_id = "vpc-0fde55d20fc96124f"
private_subnets = [
  "subnet-077f3da23e5bc7ef9",
  "subnet-0dd3ca63d48f3760b",
]
public_bastion_sg_group_id = "sg-0a9de56012f82a7e1"
public_bastion_sg_group_name = "public-bastion-sg-20240420145546446600000003"
public_bastion_sg_group_vpc_id = "vpc-0fde55d20fc96124f"
public_subnets = [
  "subnet-0382219d0a8fcaf95",
  "subnet-0ad0465d8d977c356",
]
vpc_cidr_block = "10.0.0.0/16"
vpc_id = "vpc-0fde55d20fc96124f"
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-rea                                                                                                                                                                                          fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos$


~~~~