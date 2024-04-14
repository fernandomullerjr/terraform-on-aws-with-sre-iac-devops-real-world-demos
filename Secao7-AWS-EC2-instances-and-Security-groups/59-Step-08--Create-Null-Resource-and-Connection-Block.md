
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "59. Step-08: Create Null Resource and Connection Block."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  59. Step-08: Create Null Resource and Connection Block

## Step-08: c9-nullresource-provisioners.tf

### Step-08-01: Define null resource in c1-versions.tf

- Learn about [Terraform Null Resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- Define null resource in c1-versions.tf in `terraform block`

```tf
    null = {
      source = "hashicorp/null"
      version = "~> 3.0.0"
    }    
```




- Ajustar o arquivo c1-versions.tf
incluir o provider null

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c1-versions.tf

código ajustado:

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

~~~~







## null_resource

<https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource>

The null_resource resource implements the standard resource lifecycle but takes no further action. On Terraform 1.4 and later, use the terraform_data resource type instead.

The triggers argument allows specifying an arbitrary set of values that, when changed, will cause the resource to be replaced.
Example Usage

~~~~tf
resource "aws_instance" "cluster" {
  count         = 3
  ami           = "ami-0dcc1e21636832c5d"
  instance_type = "m5.large"

  # ...
}

# The primary use-case for the null resource is as a do-nothing container
# for arbitrary actions taken by a provisioner.
#
# In this example, three EC2 instances are created and then a
# null_resource instance is used to gather data about all three
# and execute a single action that affects them all. Due to the triggers
# map, the null_resource will be replaced each time the instance ids
# change, and thus the remote-exec provisioner will be re-run.
resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster[*].id)
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = element(aws_instance.cluster[*].public_ip, 0)
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "bootstrap-cluster.sh ${join(" ",
      aws_instance.cluster[*].private_ip)}",
    ]
  }
}
~~~~


- Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>




- Manifesto obtido do zip

~~~~tf
# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }  

## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
/*  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }  
  */

}

# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)
~~~~






## Provisioners

<https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax>

Provisioners

You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.




## PENDENTE
- VER SOBRE
Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>






# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>