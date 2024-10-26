
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "77. Step-04: Review EC2 TF Manifests and Create ACM Module."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  77. Step-04: Review EC2 TF Manifests and Create ACM Module

## Step-05: c7-04-ec2instance-private-app1.tf

- We will change the module name from `ec2_private` to `ec2_private_app1`
- We will change the `name` to `"${var.environment}-app1"`

```tf
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets for App1
module "ec2_private_app1" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.5.0"    
  # insert the 10 required variables here
  name                   = "${var.environment}-app1"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags


# Changes as part of Module version from 2.17.0 to 5.5.0
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
}
```



## Step-06: c7-05-ec2instance-private-app2.tf

- Create new EC2 Instances for App2 Application
- **Module Name:** ec2_private_app2
- **Name:** `"${var.environment}-app2"`
- **User Data:** `user_data = file("${path.module}/app2-install.sh")`

```tf
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets for App2
module "ec2_private_app2" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.5.0"    
  # insert the 10 required variables here
  name                   = "${var.environment}-app2"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app2-install.sh")
  tags = local.common_tags

# Changes as part of Module version from 2.17.0 to 5.5.0
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
}
```

## Step-07: c7-02-ec2instance-outputs.tf

- Update App1 and App2 Outputs based on new module names

```tf

# Private EC2 Instances - App1
## ec2_private_instance_ids
output "ec2_private_instance_ids_app1" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2_private_app1: ec2private.id ]   
}

## ec2_private_ip
output "ec2_private_ip_app1" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2_private_app1: ec2private.private_ip ]  
}


# Private EC2 Instances - App2
## ec2_private_instance_ids
output "ec2_private_instance_ids_app2" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2_private_app2: ec2private.id ]   
}

## ec2_private_ip
output "ec2_private_ip_app2" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2_private_app2: ec2private.private_ip ]  
}
```

## Step-08: c11-acm-certificatemanager.tf

- [Terraform AWS ACM Module](https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest)
- Create a SAN SSL Certificate using DNS Validation with Route53
- This is required for us with ALB Load Balancer HTTPS Listener to associate SSL certificate to it
- Test trimsuffic function using `terraform console`

```tf
# Terraform Console
terraform console

# Provide Trim Suffix Function
trimsuffix("devopsincloud.com.", ".")

# Verify Output
"devopsincloud.com"
```

- **ACM Module Terraform Configuration**

```tf
# ACM Module - To create and Verify SSL Certificates
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  #version = "2.14.0"
  version = "5.0.0"

  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id      = data.aws_route53_zone.mydomain.zone_id 

  subject_alternative_names = [
    "*.devopsincloud.com"
  ]
  tags = local.common_tags

  # Validation Method
  validation_method = "DNS"
  wait_for_validation = true  
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}
```








- Ajustando c7-04-ec2instance-private.tf
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao10-AWS-ALB-Context-path/manifestos/c7-04-ec2instance-private.tf


- Criando c7-05-ec2instance-private-app2.tf
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao10-AWS-ALB-Context-path/manifestos/c7-05-ec2instance-private-app2.tf

pegando da pasta local

~~~~tf
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets for App2
module "ec2_private_app2" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.6.0"    
  # insert the 10 required variables here
  name                   = "${var.environment}-app2"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app2-install.sh")
  tags = local.common_tags

# Changes as part of Module version from 2.17.0 to 5.5.0
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]

}
~~~~



- Continua em 02:35h
step 07


# ############################################################################
# ############################################################################
# ############################################################################
#  PENDENTE

- Continua em 02:35h
step 07

- Propagação dos NS para o dominio devopsmind.shop da Hostinger propagar com o NS da AWS
criado Hosted zone que nao existia mais, atualizados NS no Hostinger no dia 14/07/204 as 21:45h
<https://dnschecker.org/#NS/devopsmind.shop>
<https://www.whatsmydns.net/#NS/devopsmind.shop>

- Configurar ACM.
ver video <https://www.youtube.com/watch?v=yB3zUwfrsWo> umas idéias e www, etc
s3





# ############################################################################
# ############################################################################
# ############################################################################
# dia 26/10/2024

hoje dia 26/10/2024

propagação OK em todos lugares

menos na China



nslookup seu-dominio.com
nslookup devopsmind.shop
dig devopsmind.shop



> dig devopsmind.shop

; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> devopsmind.shop
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6918
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;devopsmind.shop.               IN      A

;; AUTHORITY SECTION:
devopsmind.shop.        900     IN      SOA     ns-1785.awsdns-31.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400

;; Query time: 22 msec
;; SERVER: 8.8.8.8#53(8.8.8.8) (UDP)
;; WHEN: Sat Oct 26 10:58:19 -03 2024
;; MSG SIZE  rcvd: 131

> date
Sat Oct 26 10:58:22 -03 2024



curl "https://api.dnschecker.org/propagation/dns/A/seu-dominio.com"

curl "https://api.dnschecker.org/propagation/dns/NS/devopsmind.shop"




## Step-05: c7-04-ec2instance-private-app1.tf
- We will change the module name from `ec2_private` to `ec2_private_app1`
- We will change the `name` to `"${var.environment}-app1"`
```t
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets for App1
module "ec2_private_app1" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.5.0"    
  # insert the 10 required variables here
  name                   = "${var.environment}-app1"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags


# Changes as part of Module version from 2.17.0 to 5.5.0
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
}
```




- Ajustando nome do arquivo
de:
c7-04-ec2instance-private.tf
para:
c7-04-ec2instance-private-app1.tf






## Step-06: c7-05-ec2instance-private-app2.tf
- Create new EC2 Instances for App2 Application
- **Module Name:** ec2_private_app2
- **Name:** `"${var.environment}-app2"`
- **User Data:** `user_data = file("${path.module}/app2-install.sh")`
```t
# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets for App2
module "ec2_private_app2" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.5.0"    
  # insert the 10 required variables here
  name                   = "${var.environment}-app2"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app2-install.sh")
  tags = local.common_tags

# Changes as part of Module version from 2.17.0 to 5.5.0
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
}
```

## Step-07: c7-02-ec2instance-outputs.tf
- Update App1 and App2 Outputs based on new module names
```t

# Private EC2 Instances - App1
## ec2_private_instance_ids
output "ec2_private_instance_ids_app1" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2_private_app1: ec2private.id ]   
}

## ec2_private_ip
output "ec2_private_ip_app1" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2_private_app1: ec2private.private_ip ]  
}


# Private EC2 Instances - App2
## ec2_private_instance_ids
output "ec2_private_instance_ids_app2" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2_private_app2: ec2private.id ]   
}

## ec2_private_ip
output "ec2_private_ip_app2" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2_private_app2: ec2private.private_ip ]  
}
```






- Ajustando arquivo de Outputs
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao10-AWS-ALB-Context-path/manifestos/c7-02-ec2instance-outputs.tf




git status
git add .
git commit -m "77. Step-04: Review EC2 TF Manifests and Create ACM Module. Ajustando arquivo de Outputs"
git push
git status