

# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "72. Step-05: Create ALB Listeners and Outputs New."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  72. Step-05: Create ALB Listeners and Outputs New

## Step-04: c10-02-ALB-application-loadbalancer.tf

- Create AWS Application Load Balancer Terraform configuration using [ALB Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest)

```tf
# Terraform AWS Application Load Balancer (ALB)
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  #version = "5.16.0"
  version = "9.3.0"

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  #security_groups = [module.loadbalancer_sg.this_security_group_id]
  security_groups = [module.loadbalancer_sg.security_group_id]

  # For example only
  enable_deletion_protection = false

# Listeners
  listeners = {
    # Listener-1: my-http-listener
    my-http-listener = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "mytg1"
      }         
    }# End of my-http-listener
  }# End of listeners block

# Target Groups
  target_groups = {
   # Target Group-1: mytg1     
   mytg1 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }# End of health_check Block
      tags = local.common_tags # Target Group Tags 
    } # END of Target Group: mytg1
  } # END OF target_groups Block
  tags = local.common_tags # ALB Tags
}

# Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k, v in module.ec2_private: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}

## k = ec2_instance
## v = ec2_instance_details

## TEMP App Outputs
output "zz_ec2_private" {
  #value = {for k, v in module.ec2_private: k => v}
  value = {for ec2_instance, ec2_instance_details in module.ec2_private: ec2_instance => ec2_instance_details}
}
```


## Step-05: c10-03-ALB-application-loadbalancer-outputs.tf

```tf
# Terraform AWS Application Load Balancer (ALB) Outputs
################################################################################
# Load Balancer
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb.zone_id
}

################################################################################
# Listener(s)
################################################################################

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

################################################################################
# Target Group(s)
################################################################################

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb.target_groups
}
```







# ############################################################################
# ############################################################################
# ############################################################################
#  72. Step-05: Create ALB Listeners and Outputs New

- Continua em
1:29min



## Dia 04/07/2024

Efetuando plan

~~~~bash
devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ terraform plan
╷
│ Error: Invalid function argument
│
│   on c9-nullresource-provisioners.tf line 10, in resource "null_resource" "name":
│   10:     private_key = file("private-key/terraform-key.pem")
│     ├────────────────
│     │ while calling file(path)
│
│ Invalid value for "path" parameter: no file exists at "private-key/terraform-key.pem"; this function works only with files that are distributed as part of the configuration source code, so if this file will be created by a resource in this configuration you must
│ instead obtain this result from an attribute of that resource.
╵
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ date
Thu 04 Jul 2024 11:55:12 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$

~~~~



- Criada a pasta e a chave SSH

agora o plan rolou

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ ls
app1-install.sh                                   c1-versions.tf           c4-02-vpc-module.tf               c5-04-securitygroup-privatesg.tf       c7-02-ec2instance-outputs.tf  c9-nullresource-provisioners.tf
c10-01-ALB-application-loadbalancer-variables.tf  c2-generic-variables.tf  c4-03-vpc-outputs.tf              c5-05-securitygroup-loadbalancersg.tf  c7-03-ec2instance-bastion.tf  local-exec-output-files
c10-02-ALB-application-loadbalancer.tf            c3-local-values.tf       c5-02-securitygroup-outputs.tf    c6-01-datasource-ami.tf                c7-04-ec2instance-private.tf
c10-03-ALB-application-loadbalancer-outputs.tf    c4-01-vpc-variables.tf   c5-03-securitygroup-bastionsg.tf  c7-01-ec2instance-variables.tf         c8-elasticip.tf
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ ls
app1-install.sh                                   c1-versions.tf           c4-02-vpc-module.tf               c5-04-securitygroup-privatesg.tf       c7-02-ec2instance-outputs.tf  c9-nullresource-provisioners.tf
c10-01-ALB-application-loadbalancer-variables.tf  c2-generic-variables.tf  c4-03-vpc-outputs.tf              c5-05-securitygroup-loadbalancersg.tf  c7-03-ec2instance-bastion.tf  local-exec-output-files
c10-02-ALB-application-loadbalancer.tf            c3-local-values.tf       c5-02-securitygroup-outputs.tf    c6-01-datasource-ami.tf                c7-04-ec2instance-private.tf  private-key
c10-03-ALB-application-loadbalancer-outputs.tf    c4-01-vpc-variables.tf   c5-03-securitygroup-bastionsg.tf  c7-01-ec2instance-variables.tf         c8-elasticip.tf
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao9-AWS-Application-Load-Balancer/manifestos$ terraform plan
module.alb.data.aws_partition.current: Reading...
module.ec2_public.data.aws_partition.current: Reading...
data.aws_ami.amzlinux2: Reading...
module.alb.data.aws_partition.current: Read complete after 0s [id=aws]
module.ec2_public.data.aws_partition.current: Read complete after 0s [id=aws]
data.aws_ami.amzlinux2: Read complete after 1s [id=ami-0241b1d769b029352]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # aws_eip.bastion_eip will be created
  + resource "aws_eip" "bastion_eip" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "environment" = "dev"
          + "owners"      = "SAP"
        }
      + tags_all             = {
          + "environment" = "dev"
          + "owners"      = "SAP"
        }
      + vpc                  = (known after apply)
    }

  # aws_lb_target_group_attachment.mytg1["0"] will be created
  + resource "aws_lb_target_group_attachment" "mytg1" {
      + id               = (known after apply)
      + port             = 80
      + target_group_arn = (known after apply)
      + target_id        = (known after apply)
    }

  # aws_lb_target_group_attachment.mytg1["1"] will be created
  + resource "aws_lb_target_group_attachment" "mytg1" {
      + id               = (known after apply)
      + port             = 80
      + target_group_arn = (known after apply)
      + target_id        = (known after apply)
    }


~~~~