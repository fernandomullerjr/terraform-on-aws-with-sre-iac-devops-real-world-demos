
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "22. Step-06: Part-2: Create EC2 Instance Resource in Terraform."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 22. Step-06: Part-2: Create EC2 Instance Resource in Terraform

## Step-04: In c2-ec2instance.tf -  Create Resource Block
- Understand about [Resources](https://www.terraform.io/docs/language/resources/index.html)
- Create [EC2 Instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- Understand about [File Function](https://www.terraform.io/docs/language/functions/file.html)
- Understand about [Resources - Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)
- Understand about [Resources - Attribute Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference)

```tf
# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
```


## Step-05: Review file app1-install.sh
```sh
#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome to StackSimplify - APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
```

## Step-06: Execute Terraform Commands
```t
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
1) No changes - Just prints the execution plan

# Terraform Apply
terraform apply 
[or]
terraform apply -auto-approve
Observations:
1) Create resources on cloud
2) Created terraform.tfstate file when you run the terraform apply command
```

## Step-07: Access Application
- **Important Note:** verify if default VPC security group has a rule to allow port 80
```t
# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html

# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html
```





# ############################################################################
# ############################################################################
# ############################################################################
# 22. Step-06: Part-2: Create EC2 Instance Resource in Terraform

- Atualizando código do manifesto para criar EC2
atualizando ami id
ajustando familia para t2

~~~~tf
# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0e731c8a588258d0d"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
~~~~


- Adicionando o versions
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver/c1-versions.tf

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = "us-east-1"
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
~~~~



cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

~~~~bash

fernando@debian10x64:~$ cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ terraform init

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
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ terraform plan

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Retrieving AWS account details: validating provider credentials: retrieving caller identity from STS: operation error STS: GetCallerIdentity, https response error StatusCode: 403, RequestID: badc7adc-e545-4edc-b835-b702ff76f922, api error InvalidClientTokenId: The security token included in the request is invalid.
│
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on c1-versions.tf line 12, in provider "aws":
│   12: provider "aws" {
│
╵
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$


fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ assume

? Please select the profile you would like to assume: sandbox-fernando-labs/AdministratorAccess
[i] To assume this profile again later without needing to select it, run this command:
> assume sandbox-fernando-labs/AdministratorAccess
[✔] [sandbox-fernando-labs/AdministratorAccess](us-east-1) session credentials will expire in 12 hours
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.myec2vm will be created
  + resource "aws_instance" "myec2vm" {
      + ami                                  = "ami-0e731c8a588258d0d"
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
      + key_name                             = (known after apply)
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
          + "Name" = "EC2 Demo"
        }
      + tags_all                             = {
          + "Name" = "EC2 Demo"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "d6194f48053da708f6aeb8edf069363ca9625c3d"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$




fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.myec2vm will be created
  + resource "aws_instance" "myec2vm" {
      + ami                                  = "ami-0e731c8a588258d0d"
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
      + key_name                             = (known after apply)
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
          + "Name" = "EC2 Demo"
        }
      + tags_all                             = {
          + "Name" = "EC2 Demo"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "d6194f48053da708f6aeb8edf069363ca9625c3d"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_instance.myec2vm: Creating...
aws_instance.myec2vm: Still creating... [10s elapsed]
aws_instance.myec2vm: Still creating... [20s elapsed]
aws_instance.myec2vm: Creation complete after 29s [id=i-07da6c658e15eba43]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$

~~~~










Step-07: Access Application

    Important Note: verify if default VPC security group has a rule to allow port 80

# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html

# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html



Instance ID
 i-07da6c658e15eba43 (EC2 Demo)
Public IPv4 address
 44.202.134.47 |open address 
Private IPv4 addresses
 172.31.88.96


 # Access index.html
http://44.202.134.47/index.html
http://44.202.134.47/app1/index.html

# Access metadata.html
http://44.202.134.47/app1/metadata.html


Inbound security group rules successfully modified on security group (sg-09208ff95ee5d3c0d | default)
Details



curl http://44.202.134.47/index.html
curl http://44.202.134.47/app1/index.html
curl http://44.202.134.47/app1/metadata.html

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ curl http://44.202.134.47/index.html
<h1>Welcome to StackSimplify - APP-1</h1>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ curl http://44.202.134.47/app1/index.html
<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ curl http://44.202.134.47/app1/metadata.html
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
  <title>401 - Unauthorized</title>
 </head>
 <body>
  <h1>401 - Unauthorized</h1>
 </body>
</html>
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$

~~~~



## PENDENTE
- Ver sobre erro "401 - Unauthorized" ao tentar acessar página com Metadata.
http://44.202.134.47/app1/metadata.html