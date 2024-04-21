
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




- Efetuando init, validate, fmt, plan, apply

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ terraform init

Initializing the backend...
Initializing modules...
Downloading registry.terraform.io/terraform-aws-modules/ec2-instance/aws 5.6.0 for ec2_private...
- ec2_private in .terraform/modules/ec2_private
Downloading registry.terraform.io/terraform-aws-modules/ec2-instance/aws 5.6.0 for ec2_public...
- ec2_public in .terraform/modules/ec2_public
Downloading registry.terraform.io/terraform-aws-modules/elb/aws 4.0.1 for elb...
- elb in .terraform/modules/elb
- elb.elb in .terraform/modules/elb/modules/elb
- elb.elb_attachment in .terraform/modules/elb/modules/elb_attachment
Downloading registry.terraform.io/terraform-aws-modules/security-group/aws 5.1.0 for loadbalancer_sg...
- loadbalancer_sg in .terraform/modules/loadbalancer_sg
Downloading registry.terraform.io/terraform-aws-modules/security-group/aws 5.1.0 for private_sg...
- private_sg in .terraform/modules/private_sg
Downloading registry.terraform.io/terraform-aws-modules/security-group/aws 5.1.0 for public_bastion_sg...
- public_bastion_sg in .terraform/modules/public_bastion_sg
Downloading registry.terraform.io/terraform-aws-modules/vpc/aws 5.4.0 for vpc...
- vpc in .terraform/modules/vpc

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 3.29.0, >= 4.0.0, >= 4.66.0, >= 5.0.0"...
- Finding hashicorp/null versions matching "~> 3.0"...
- Installing hashicorp/aws v5.46.0...
- Installed hashicorp/aws v5.46.0 (signed by HashiCorp)
- Installing hashicorp/null v3.2.2...
- Installed hashicorp/null v3.2.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ date
Sun 21 Apr 2024 06:33:54 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$


fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ terraform fmt
c1-versions.tf
c10-02-ELB-classic-loadbalancer.tf
c2-generic-variables.tf
c3-local-values.tf
c4-01-vpc-variables.tf
c4-02-vpc-module.tf
c5-02-securitygroup-outputs.tf
c5-03-securitygroup-bastionsg.tf
c5-04-securitygroup-privatesg.tf
c5-05-securitygroup-loadbalancersg.tf
c6-01-datasource-ami.tf
c7-01-ec2instance-variables.tf
c7-02-ec2instance-outputs.tf
c7-03-ec2instance-bastion.tf
c7-04-ec2instance-private.tf
c8-elasticip.tf
c9-nullresource-provisioners.tf
ec2instance.auto.tfvars
terraform.tfvars
vpc.auto.tfvars
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$




Plan: 44 to add, 0 to change, 0 to destroy.



module.elb.module.elb_attachment.aws_elb_attachment.this[1]: Creating...
module.elb.module.elb_attachment.aws_elb_attachment.this[0]: Creating...
module.elb.module.elb_attachment.aws_elb_attachment.this[0]: Creation complete after 1s [id=HR-stag-myelb-2024042121414721270000000b]
module.elb.module.elb_attachment.aws_elb_attachment.this[1]: Creation complete after 1s [id=HR-stag-myelb-2024042121414726420000000c]

Apply complete! Resources: 44 added, 0 changed, 0 destroyed.

Outputs:

azs = tolist([
  "us-east-1a",
  "us-east-1b",
])
ec2_bastion_public_instance_ids = "i-05c0f68c4c595d3f3"
ec2_bastion_public_ip = ""
ec2_private_instance_ids = [
  "i-08619ec5c9728d669",
  "i-02c53a59adacdaff9",
]
ec2_private_ip = [
  "10.0.1.112",
  "10.0.2.41",
]
elb_dns_name = "HR-stag-myelb-254475381.us-east-1.elb.amazonaws.com"
elb_id = "HR-stag-myelb"
elb_instances = []
elb_name = "HR-stag-myelb"
elb_source_security_group_id = "sg-0f8130f819ca159a1"
elb_zone_id = "Z35SXDOTRQ7X7K"
nat_public_ips = tolist([
  "23.21.189.71",
])
private_sg_group_id = "sg-06a7f669d74f175ab"
private_sg_group_name = "private-sg-20240421213906720100000004"
private_sg_group_vpc_id = "vpc-0d48956e1a49a80d2"
private_subnets = [
  "subnet-0a5c42180f17ac6e5",
  "subnet-0da1d31cde5bd574b",
]
public_bastion_sg_group_id = "sg-0c092a56020220231"
public_bastion_sg_group_name = "public-bastion-sg-20240421213906720800000005"
public_bastion_sg_group_vpc_id = "vpc-0d48956e1a49a80d2"
public_subnets = [
  "subnet-0608eadb807ae634c",
  "subnet-0f1543346d8f938e0",
]
vpc_cidr_block = "10.0.0.0/16"
vpc_id = "vpc-0d48956e1a49a80d2"
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$

~~~~



HR-stag-myelb-254475381.us-east-1.elb.amazonaws.com

- Testando

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ curl HR-stag-myelb-254475381.us-east-1.elb.amazonaws.com
<h1>Welcome to StackSimplify - APP-1</h1>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ date
Sun 21 Apr 2024 06:45:42 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$

~~~~




- Testando na porta 81 também:

HR-stag-myelb-254475381.us-east-1.elb.amazonaws.com:81

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ curl HR-stag-myelb-254475381.us-east-1.elb.amazonaws.com:81
<h1>Welcome to StackSimplify - APP-1</h1>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ date
Sun 21 Apr 2024 06:46:26 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$

~~~~




- Verificando instancias no ELB
todas "Em serviço" corretamente:

Instâncias de destino (2)

As instâncias atualmente registradas em seu balanceador de carga são exibidas. Para cancelar o registro de instâncias, selecione-as e escolha Cancelar registro. Para registrar e cancelar o registro de instâncias simultaneamente, escolha Gerenciar instâncias.
 	
Tempo de execução
	i-02c53a59adacdaff9	stag-vm	
Em serviço	Não aplicável	private-sg-20240421213906720100000004	us-east-1b	-	subnet-0da1d31cde5bd574b	21 de abril de 2024, 18:41 (UTC-03:00)
	i-08619ec5c9728d669	stag-vm	
Em serviço	Não aplicável	private-sg-20240421213906720100000004	us-east-1a	-	subnet-0a5c42180f17ac6e5	21 de abril de 2024, 18:41 (UTC-03





http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/
<http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/>

http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/metadata.html
<http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/metadata.html>


~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ curl http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/
<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$


fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$ curl http://hr-stag-myelb-254475381.us-east-1.elb.amazonaws.com/app1/metadata.html
{
  "accountId" : "058264180843",
  "architecture" : "x86_64",
  "availabilityZone" : "us-east-1b",
  "billingProducts" : null,
  "devpayProductCodes" : null,
  "marketplaceProductCodes" : null,
  "imageId" : "ami-045602374a1982480",
  "instanceId" : "i-02c53a59adacdaff9",
  "instanceType" : "t2.micro",
  "kernelId" : null,
  "pendingTime" : "2024-04-21T21:41:02Z",
  "privateIp" : "10.0.2.41",
  "ramdiskId" : null,
  "region" : "us-east-1",
  "version" : "2017-09-30"
}fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao8-AWS-Classic-Load-Balancer/manifestos$

~~~~