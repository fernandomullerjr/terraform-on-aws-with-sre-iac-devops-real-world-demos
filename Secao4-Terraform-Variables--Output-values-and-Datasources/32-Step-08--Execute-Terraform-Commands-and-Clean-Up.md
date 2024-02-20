
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "32. Step-08: Execute Terraform Commands and Clean-Up."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
#  32. Step-08: Execute Terraform Commands and Clean-Up

Step-07: Execute Terraform Commands

# Terraform Initialize
terraform init
Observation:
1) Initialized Local Backend
2) Downloaded the provider plugins (initialized plugins)
3) Review the folder structure ".terraform folder"

# Terraform Validate
terraform validate
Observation:
1) If any changes to files, those will come as printed in stdout (those file names will be printed in CLI)

# Terraform Plan
terraform plan
Observation:
1) Verify the latest AMI ID picked and displayed in plan
2) Verify the number of resources that going to get created
3) Verify the variable replacements worked as expected

# Terraform Apply
terraform apply 
[or]
terraform apply -auto-approve
Observations:
1) Create resources on cloud
2) Created terraform.tfstate file when you run the terraform apply command
3) Verify the EC2 Instance AMI ID which got created






cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests


~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 5.0.0"...
- Installing hashicorp/aws v5.37.0...
- Installed hashicorp/aws v5.37.0 (signed by HashiCorp)

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
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$



fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$



fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ terraform plan
data.aws_ami.amzlinux2: Reading...
data.aws_ami.amzlinux2: Read complete after 2s [id=ami-03c951bbe993ea087]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.myec2vm will be created
  + resource "aws_instance" "myec2vm" {
      + ami                                  = "ami-03c951bbe993ea087"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "terraform-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "EC2 Demo 2"
        }
      + tags_all                             = {
          + "Name" = "EC2 Demo 2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "b581bd3b94c2f65091edb9db43eaa59e38d6efb3"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

  # aws_security_group.vpc-ssh will be created
  + resource "aws_security_group" "vpc-ssh" {
      + arn                    = (known after apply)
      + description            = "Dev VPC SSH"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow all ip and ports outbound"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow Port 22"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "vpc-ssh"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "vpc-ssh"
        }
      + tags_all               = {
          + "Name" = "vpc-ssh"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.vpc-web will be created
  + resource "aws_security_group" "vpc-web" {
      + arn                    = (known after apply)
      + description            = "Dev VPC Web"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow all ip and ports outbound"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow Port 443"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow Port 80"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "vpc-web"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "vpc-web"
        }
      + tags_all               = {
          + "Name" = "vpc-web"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_publicdns = (known after apply)
  + instance_publicip  = (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$

~~~~




validando ami na pagina da AWS

ID da AMI
 ami-03c951bbe993ea087
Tipo de imagem
machine
Detalhes da plataforma
Linux/UNIX
Tipo de dispositivo raiz
EBS
Nome da AMI
 amzn2-ami-hvm-2.0.20240131.0-x86_64-gp2
ID da conta do proprietário
 137112412989
Arquitetura
x86_64




apply

~~~~bash

aws_instance.myec2vm: Still creating... [1m10s elapsed]
aws_instance.myec2vm: Creation complete after 1m15s [id=i-04b85fdfd9a883f4d]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

instance_publicdns = "ec2-54-144-107-175.compute-1.amazonaws.com"
instance_publicip = "54.144.107.175"
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$



fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ curl 54.144.107.175
<h1>Welcome to StackSimplify - APP-1</h1>
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$


~~~~



Step-08: Access Application

# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html

# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html

Step-09: Clean-Up

# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*



- Clean

~~~~bash

aws_instance.myec2vm: Destroying... [id=i-04b85fdfd9a883f4d]
aws_instance.myec2vm: Still destroying... [id=i-04b85fdfd9a883f4d, 10s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-04b85fdfd9a883f4d, 20s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-04b85fdfd9a883f4d, 30s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-04b85fdfd9a883f4d, 40s elapsed]
aws_instance.myec2vm: Destruction complete after 42s
aws_security_group.vpc-ssh: Destroying... [id=sg-00ba347efe9329b73]
aws_security_group.vpc-web: Destroying... [id=sg-0e8f05a29f04c8b9a]
aws_security_group.vpc-ssh: Destruction complete after 1s
aws_security_group.vpc-web: Destruction complete after 1s

Destroy complete! Resources: 3 destroyed.
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$

~~~~