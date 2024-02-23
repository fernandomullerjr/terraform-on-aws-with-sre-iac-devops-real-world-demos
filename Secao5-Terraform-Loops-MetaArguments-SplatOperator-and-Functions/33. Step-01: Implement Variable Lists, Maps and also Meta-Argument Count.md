
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "33. Step-01: Implement Variable Lists, Maps and also Meta-Argument Count."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
#  33. Step-01: Implement Variable Lists, Maps and also Meta-Argument Count

Terraform For Loops, Lists, Maps and Count Meta-Argument
Step-00: Pre-requisite Note

    We are using the default vpc in us-east-1 region


Step-01: Introduction

    Terraform Meta-Argument: Count
    Terraform Lists & Maps
        List(string)
        map(string)
    Terraform for loops
        for loop with List
        for loop with Map
        for loop with Map Advanced
    Splat Operators
        Legacy Splat Operator .*.
        Generalized Splat Operator (latest)
        Understand about Terraform Generic Splat Expression [*] when dealing with count Meta-Argument and multiple output values

Step-02: c1-versions.tf

    No changes


Step-03: c2-variables.tf - Lists and Maps

# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instnace Type"
  type = list(string)
  default = ["t3.micro", "t3.small"]
}


# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instnace Type"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa"  = "t3.small"
    "prod" = "t3.large"
  }
}


- Criando o List e o Map:

~~~~tf
# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instnace Type"
  type        = string
  default     = "t2.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type        = string
  default     = "terraform-key"
}


# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t2.micro", "t2.small", "t2.large"]  
}

# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa" = "t2.small"
    "prod" = "t2.large"
  }
}
~~~~




Step-04: c3-ec2securitygroups.tf and c4-ami-datasource.tf

    No changes to both files


Step-05: c5-ec2instance.tf


# How to reference List values ?
instance_type = var.instance_type_list[1]

# How to reference Map values ?
instance_type = var.instance_type_map["prod"]

# Meta-Argument Count
count = 2

# count.index
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }


~~~~tf
# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  #instance_type = var.instance_type_list[1]  # For List
  #nstance_type = var.instance_type_map["prod"]  # For Map
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  count = 2
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
}

/*
# Drawbacks of using count in this example
- Resource Instances in this case were identified using index numbers 
instead of string values like actual subnet_id
- If an element was removed from the middle of the list, 
every instance after that element would see its subnet_id value 
change, resulting in more remote object changes than intended. 
- Even the subnet_ids should be pre-defined or we need to get them again 
using for_each or for using various datasources
- Using for_each gives the same flexibility without the extra churn.
*/
~~~~







- Teste, deu erro

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$ terraform plan
╷
│ Error: Missing resource instance key
│
│   on c6-outputs.tf line 6, in output "instance_publicip":
│    6:   value = aws_instance.myec2vm.public_ip
│
│ Because aws_instance.myec2vm has "count" set, its attributes must be accessed on specific instances.
│
│ For example, to correlate with indices of a referring resource, use:
│     aws_instance.myec2vm[count.index]
╵
╷
│ Error: Missing resource instance key
│
│   on c6-outputs.tf line 12, in output "instance_publicdns":
│   12:   value = aws_instance.myec2vm.public_dns
│
│ Because aws_instance.myec2vm has "count" set, its attributes must be accessed on specific instances.
│
│ For example, to correlate with indices of a referring resource, use:
│     aws_instance.myec2vm[count.index]
╵
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
~~~~



- Necessário ajustar os outputs
aula:
34. Step-02: Implement Outputs with For Loops and Splat Operators




# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- É possível usar listas de List e Map para as strings do Terraform.
- List começa em 0, exemplo: 0, 1, 2,...