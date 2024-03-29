
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "46. Step-05: Test Basic VPC Module by executing Terraform Commands."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 46. Step-05: Test Basic VPC Module by executing Terraform Commands


## Step-03: Execute Terraform Commands

```bash
# Working Folder
terraform-manifests/v1-vpc-module

# Terraform Initialize
terraform init
Observation:
1. Verify if modules got downloaded to .terraform folder

# Terraform Validate
terraform validate

# Terraform plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
Observation:
1) Verify VPC
2) Verify Subnets
3) Verify IGW
4) Verify Public Route for Public Subnets
5) Verify no public route for private subnets
6) Verify NAT Gateway and Elastic IP for NAT Gateway
7) Verify NAT Gateway route for Private Subnets
8) Verify no public route or no NAT Gateway route to Database Subnets
9) Verify Tags

# Terraform Destroy
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```





# ############################################################################
# ############################################################################
# ############################################################################
# 46. Step-05: Test Basic VPC Module by executing Terraform Commands

- Acessar o diretório dos manifestos

cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module

rodando os comandos

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module$ terraform init

Initializing the backend...
Initializing modules...
Downloading registry.terraform.io/terraform-aws-modules/vpc/aws 5.4.0 for vpc...
- vpc in .terraform/modules/vpc

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 5.0.0"...
- Installing hashicorp/aws v5.43.0...
- Installed hashicorp/aws v5.43.0 (signed by HashiCorp)

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
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module$ terraform fmt
c1-versions.tf
c2-generic-variables.tf
c3-vpc.tf
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module$ terraform validate
Success! The configuration is valid.

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module$

~~~~




- Neste diretório ficam os detalhes do módulo:

/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module/.terraform/modules/modules.json

~~~~json
{"Modules":[{"Key":"","Source":"","Dir":"."},{"Key":"vpc","Source":"registry.terraform.io/terraform-aws-modules/vpc/aws","Version":"5.4.0","Dir":".terraform/modules/vpc"}]}
~~~~




- Plan falhando:

~~~~bash
Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Retrieving AWS account details: validating provider credentials: retrieving caller identity from STS: operation error STS: GetCallerIdentity, https response error StatusCode: 403, RequestID: 76e63172-b64d-47e0-9a54-6844216864fa, api error InvalidClientTokenId: The security token included in the request is invalid.
│
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on c1-versions.tf line 13, in provider "aws":
│   13: provider "aws" {

~~~~



- Ajustando:

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module/c1-versions.tf

colocando conforme:
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/autenticar-terraform-com-aws-sso-assume_role.md

~~~~tf

provider "aws" {
  region  = var.aws_region

  profile = "fernandomullerjunior-labs/AdministratorAccess"

    assume_role {
    role_arn     = "arn:aws:iam::058264180843:role/admin-role-account-sandbox"
    # (Optional) The external ID created in step 1c.
    external_id = "7755"
    session_name = "terraform-session"
  }

}
~~~~


- OK, agora o plan funcionou:

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v1-vpc-module$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vpc.aws_db_subnet_group.database[0] will be created
  + resource "aws_db_subnet_group" "database" {
      + arn                     = (known after apply)
      + description             = "Database subnet group for vpc-dev"
      + id                      = (known after apply)
      + name                    = "vpc-dev"
      + name_prefix             = (known after apply)
      + subnet_ids              = (known after apply)
      + supported_network_types = (known after apply)
      + tags                    = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
        }
      + tags_all                = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
        }
      + tags_all               = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
        }
      + tags_all               = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
        }
      + tags_all               = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-default"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-us-east-1a"
          + "Owner"       = "kalyan"
        }
      + tags_all             = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-us-east-1a"
          + "Owner"       = "kalyan"
        }
      + vpc                  = (known after apply)
    }

  # module.vpc.aws_internet_gateway.this[0] will be created
  + resource "aws_internet_gateway" "this" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
        }
      + tags_all = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-us-east-1a"
          + "Owner"       = "kalyan"
        }
      + tags_all                           = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-us-east-1a"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db"
          + "Owner"       = "kalyan"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private"
          + "Owner"       = "kalyan"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public"
          + "Owner"       = "kalyan"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public"
          + "Owner"       = "kalyan"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "database-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "database-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "database-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-db-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "database-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "private-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "private-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "private-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-private-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "private-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "public-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public-us-east-1a"
          + "Owner"       = "kalyan"
          + "Type"        = "public-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "public-subnets"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev-public-us-east-1b"
          + "Owner"       = "kalyan"
          + "Type"        = "public-subnets"
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
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
        }
      + tags_all                             = {
          + "Environment" = "dev"
          + "Name"        = "vpc-dev"
          + "Owner"       = "kalyan"
        }
    }

Plan: 25 to add, 0 to change, 0 to destroy.


~~~~





# Terraform Apply
terraform apply -auto-approve