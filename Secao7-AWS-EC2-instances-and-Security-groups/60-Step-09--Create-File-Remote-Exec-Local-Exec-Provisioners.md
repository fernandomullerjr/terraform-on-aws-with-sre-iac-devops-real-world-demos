
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "60. Step-09: Create File, Remote-Exec, Local-Exec Provisionersk."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  60. Step-09: Create File, Remote-Exec, Local-Exec Provisioners

Aula continua sobre a segunda parte do manifesto
na aula anterior foi sobre connections
agora é sobre o restante

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c9-nullresource-provisioners.tf

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





# remote-exec Provisioner
 
<https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec>

The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. To invoke a local process, see the local-exec provisioner instead. The remote-exec provisioner requires a connection and supports both ssh and winrm.

Important: Use provisioners as a last resort. There are better alternatives for most situations. Refer to Declaring Provisioners for more details.

Example usage

~~~~TF
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
~~~~






# local-exec Provisioner

<https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec>

The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource. See the remote-exec provisioner to run commands on the resource.

Note that even though the resource will be fully created when the provisioner is run, there is no guarantee that it will be in an operable state - for example system services such as sshd may not be started yet on compute resources.

Important: Use provisioners as a last resort. There are better alternatives for most situations. Refer to Declaring Provisioners for more details.

Example usage

~~~~TF
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
~~~~





- Aplicando
cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos


plan 

~~~~bash

╵
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos$ terraform plan
module.ec2_public.data.aws_partition.current: Reading...
data.aws_ami.amzlinux2: Reading...
module.ec2_public.data.aws_partition.current: Read complete after 0s [id=aws]
data.aws_ami.amzlinux2: Read complete after 1s [id=ami-0cf43e890af9e3351]

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
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all             = {
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc                  = (known after apply)
    }

  # null_resource.name will be created
  + resource "null_resource" "name" {
      + id = (known after apply)
    }

  # module.ec2_private["0"].data.aws_partition.current will be read during apply
  # (depends on a resource or a module with changes pending)
 <= data "aws_partition" "current" {
      + dns_suffix         = (known after apply)
      + id                 = (known after apply)
      + partition          = (known after apply)
      + reverse_dns_prefix = (known after apply)
    }

  # module.ec2_private["0"].aws_instance.this[0] will be created
  + resource "aws_instance" "this" {
      + ami                                  = "ami-0cf43e890af9e3351"
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
          + "Name"        = "stag-vm"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                             = {
          + "Name"        = "stag-vm"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "78929f5a2189ad3e9bf07b894710756199be4070"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + volume_tags                          = {
          + "Name" = "stag-vm"
        }
      + vpc_security_group_ids               = (known after apply)

      + credit_specification {}

      + enclave_options {
          + enabled = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = 1
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }

      + timeouts {}
    }

  # module.ec2_private["1"].data.aws_partition.current will be read during apply
  # (depends on a resource or a module with changes pending)
 <= data "aws_partition" "current" {
      + dns_suffix         = (known after apply)
      + id                 = (known after apply)
      + partition          = (known after apply)
      + reverse_dns_prefix = (known after apply)
    }

  # module.ec2_private["1"].aws_instance.this[0] will be created
  + resource "aws_instance" "this" {
      + ami                                  = "ami-0cf43e890af9e3351"
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
          + "Name"        = "stag-vm"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                             = {
          + "Name"        = "stag-vm"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "78929f5a2189ad3e9bf07b894710756199be4070"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + volume_tags                          = {
          + "Name" = "stag-vm"
        }
      + vpc_security_group_ids               = (known after apply)

      + credit_specification {}

      + enclave_options {
          + enabled = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = 1
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }

      + timeouts {}
    }

  # module.ec2_public.aws_instance.this[0] will be created
  + resource "aws_instance" "this" {
      + ami                                  = "ami-0cf43e890af9e3351"
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
          + "Name"        = "stag-BastionHost"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                             = {
          + "Name"        = "stag-BastionHost"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + volume_tags                          = {
          + "Name" = "stag-BastionHost"
        }
      + vpc_security_group_ids               = (known after apply)

      + credit_specification {}

      + enclave_options {
          + enabled = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = 1
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }

      + timeouts {}
    }

  # module.private_sg.aws_security_group.this_name_prefix[0] will be created
  + resource "aws_security_group" "this_name_prefix" {
      + arn                    = (known after apply)
      + description            = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = (known after apply)
      + name_prefix            = "private-sg-"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name"        = "private-sg"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all               = {
          + "Name"        = "private-sg"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                 = (known after apply)

      + timeouts {
          + create = "10m"
          + delete = "15m"
        }
    }

  # module.private_sg.aws_security_group_rule.egress_rules[0] will be created
  + resource "aws_security_group_rule" "egress_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "All protocols"
      + from_port                = -1
      + id                       = (known after apply)
      + ipv6_cidr_blocks         = [
          + "::/0",
        ]
      + prefix_list_ids          = []
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = -1
      + type                     = "egress"
    }

  # module.private_sg.aws_security_group_rule.ingress_rules[0] will be created
  + resource "aws_security_group_rule" "ingress_rules" {
      + cidr_blocks              = [
          + "10.0.0.0/16",
        ]
      + description              = "SSH"
      + from_port                = 22
      + id                       = (known after apply)
      + ipv6_cidr_blocks         = []
      + prefix_list_ids          = []
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 22
      + type                     = "ingress"
    }

  # module.private_sg.aws_security_group_rule.ingress_rules[1] will be created
  + resource "aws_security_group_rule" "ingress_rules" {
      + cidr_blocks              = [
          + "10.0.0.0/16",
        ]
      + description              = "HTTP"
      + from_port                = 80
      + id                       = (known after apply)
      + ipv6_cidr_blocks         = []
      + prefix_list_ids          = []
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 80
      + type                     = "ingress"
    }

  # module.public_bastion_sg.aws_security_group.this_name_prefix[0] will be created
  + resource "aws_security_group" "this_name_prefix" {
      + arn                    = (known after apply)
      + description            = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = (known after apply)
      + name_prefix            = "public-bastion-sg-"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name"        = "public-bastion-sg"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all               = {
          + "Name"        = "public-bastion-sg"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                 = (known after apply)

      + timeouts {
          + create = "10m"
          + delete = "15m"
        }
    }

  # module.public_bastion_sg.aws_security_group_rule.egress_rules[0] will be created
  + resource "aws_security_group_rule" "egress_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "All protocols"
      + from_port                = -1
      + id                       = (known after apply)
      + ipv6_cidr_blocks         = [
          + "::/0",
        ]
      + prefix_list_ids          = []
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = -1
      + type                     = "egress"
    }

  # module.public_bastion_sg.aws_security_group_rule.ingress_rules[0] will be created
  + resource "aws_security_group_rule" "ingress_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "SSH"
      + from_port                = 22
      + id                       = (known after apply)
      + ipv6_cidr_blocks         = []
      + prefix_list_ids          = []
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 22
      + type                     = "ingress"
    }

  # module.vpc.aws_db_subnet_group.database[0] will be created
  + resource "aws_db_subnet_group" "database" {
      + arn                     = (known after apply)
      + description             = "Database subnet group for HR-stag-myvpc"
      + id                      = (known after apply)
      + name                    = "hr-stag-myvpc"
      + name_prefix             = (known after apply)
      + subnet_ids              = (known after apply)
      + supported_network_types = (known after apply)
      + tags                    = {
          + "Name"        = "hr-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                = {
          + "Name"        = "hr-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                  = (known after apply)
    }

  # module.vpc.aws_default_network_acl.this[0] will be created
  + resource "aws_default_network_acl" "this" {
      + arn                    = (known after apply)
      + default_network_acl_id = (known after apply)
      + id                     = (known after apply)
      + owner_id               = (known after apply)
      + tags                   = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all               = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                 = (known after apply)

      + egress {
          + action          = "allow"
          + from_port       = 0
          + ipv6_cidr_block = "::/0"
          + protocol        = "-1"
          + rule_no         = 101
          + to_port         = 0
        }
      + egress {
          + action     = "allow"
          + cidr_block = "0.0.0.0/0"
          + from_port  = 0
          + protocol   = "-1"
          + rule_no    = 100
          + to_port    = 0
        }

      + ingress {
          + action          = "allow"
          + from_port       = 0
          + ipv6_cidr_block = "::/0"
          + protocol        = "-1"
          + rule_no         = 101
          + to_port         = 0
        }
      + ingress {
          + action     = "allow"
          + cidr_block = "0.0.0.0/0"
          + from_port  = 0
          + protocol   = "-1"
          + rule_no    = 100
          + to_port    = 0
        }
    }

  # module.vpc.aws_default_route_table.default[0] will be created
  + resource "aws_default_route_table" "default" {
      + arn                    = (known after apply)
      + default_route_table_id = (known after apply)
      + id                     = (known after apply)
      + owner_id               = (known after apply)
      + route                  = (known after apply)
      + tags                   = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all               = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                 = (known after apply)

      + timeouts {
          + create = "5m"
          + update = "5m"
        }
    }

  # module.vpc.aws_default_security_group.this[0] will be created
  + resource "aws_default_security_group" "this" {
      + arn                    = (known after apply)
      + description            = (known after apply)
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all               = {
          + "Name"        = "HR-stag-myvpc-default"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                 = (known after apply)
    }

  # module.vpc.aws_eip.nat[0] will be created
  + resource "aws_eip" "nat" {
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
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "Name"        = "HR-stag-myvpc-us-east-1a"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all             = {
          + "Name"        = "HR-stag-myvpc-us-east-1a"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc                  = (known after apply)
    }

  # module.vpc.aws_internet_gateway.this[0] will be created
  + resource "aws_internet_gateway" "this" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name"        = "HR-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all = {
          + "Name"        = "HR-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id   = (known after apply)
    }

  # module.vpc.aws_nat_gateway.this[0] will be created
  + resource "aws_nat_gateway" "this" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "Name"        = "HR-stag-myvpc-us-east-1a"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                           = {
          + "Name"        = "HR-stag-myvpc-us-east-1a"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
    }

  # module.vpc.aws_route.private_nat_gateway[0] will be created
  + resource "aws_route" "private_nat_gateway" {
      + destination_cidr_block = "0.0.0.0/0"
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + nat_gateway_id         = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)

      + timeouts {
          + create = "5m"
        }
    }

  # module.vpc.aws_route.public_internet_gateway[0] will be created
  + resource "aws_route" "public_internet_gateway" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)

      + timeouts {
          + create = "5m"
        }
    }

  # module.vpc.aws_route_table.database[0] will be created
  + resource "aws_route_table" "database" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name"        = "HR-stag-myvpc-db"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all         = {
          + "Name"        = "HR-stag-myvpc-db"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table.private[0] will be created
  + resource "aws_route_table" "private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name"        = "HR-stag-myvpc-private"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all         = {
          + "Name"        = "HR-stag-myvpc-private"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table.public[0] will be created
  + resource "aws_route_table" "public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name"        = "HR-stag-myvpc-public"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all         = {
          + "Name"        = "HR-stag-myvpc-public"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table_association.database[0] will be created
  + resource "aws_route_table_association" "database" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.database[1] will be created
  + resource "aws_route_table_association" "database" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.private[0] will be created
  + resource "aws_route_table_association" "private" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.private[1] will be created
  + resource "aws_route_table_association" "private" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.public[0] will be created
  + resource "aws_route_table_association" "public" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.public[1] will be created
  + resource "aws_route_table_association" "public" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_subnet.database[0] will be created
  + resource "aws_subnet" "database" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.151.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-db-us-east-1a"
          + "Type"        = "Private Database Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-db-us-east-1a"
          + "Type"        = "Private Database Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.database[1] will be created
  + resource "aws_subnet" "database" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.152.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-db-us-east-1b"
          + "Type"        = "Private Database Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-db-us-east-1b"
          + "Type"        = "Private Database Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.private[0] will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-private-us-east-1a"
          + "Type"        = "Private Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-private-us-east-1a"
          + "Type"        = "Private Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.private[1] will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-private-us-east-1b"
          + "Type"        = "Private Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-private-us-east-1b"
          + "Type"        = "Private Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.public[0] will be created
  + resource "aws_subnet" "public" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.101.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-public-us-east-1a"
          + "Type"        = "Public Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-public-us-east-1a"
          + "Type"        = "Public Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.public[1] will be created
  + resource "aws_subnet" "public" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.102.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name"        = "HR-stag-myvpc-public-us-east-1b"
          + "Type"        = "Public Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                                       = {
          + "Name"        = "HR-stag-myvpc-public-us-east-1b"
          + "Type"        = "Public Subnets"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_vpc.this[0] will be created
  + resource "aws_vpc" "this" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name"        = "HR-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
      + tags_all                             = {
          + "Name"        = "HR-stag-myvpc"
          + "environment" = "stag"
          + "owners"      = "HR"
        }
    }

Plan: 37 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + azs                             = [
      + "us-east-1a",
      + "us-east-1b",
    ]
  + ec2_bastion_public_instance_ids = (known after apply)
  + ec2_bastion_public_ip           = (known after apply)
  + ec2_private_instance_ids        = [
      + (known after apply),
      + (known after apply),
    ]
  + ec2_private_ip                  = [
      + (known after apply),
      + (known after apply),
    ]
  + nat_public_ips                  = [
      + (known after apply),
    ]
  + private_sg_group_id             = (known after apply)
  + private_sg_group_name           = (known after apply)
  + private_sg_group_vpc_id         = (known after apply)
  + private_subnets                 = [
      + (known after apply),
      + (known after apply),
    ]
  + public_bastion_sg_group_id      = (known after apply)
  + public_bastion_sg_group_name    = (known after apply)
  + public_bastion_sg_group_vpc_id  = (known after apply)
  + public_subnets                  = [
      + (known after apply),
      + (known after apply),
    ]
  + vpc_cidr_block                  = "10.0.0.0/16"
  + vpc_id                          = (known after apply)

~~~~




# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Padrão:
  Creation Time Provisioners - By default they are created during resource creations (terraform apply)

- É possível executar os comandos durante o destroy, usando "when = destroy".



