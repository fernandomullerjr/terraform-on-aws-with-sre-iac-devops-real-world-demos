
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "55. Step-05: Create EC2 Instance Variables and Public Bastion Instance."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 55. Step-05: Create EC2 Instance Variables and Public Bastion Instance


## Step-05: c6-01-datasource-ami.tf

```tf
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
```



## Step-06: EC2 Instances
### Step-06-01: c7-01-ec2instance-variables.tf

```tf
# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}
```





# ############################################################################
# ############################################################################
# ############################################################################
# 55. Step-05: Create EC2 Instance Variables and Public Bastion Instance

- Exemplo do repositório do curso está defasado.
- Ajustando os novos manifestos para o código atualizado, que tem o "private_instance_count":

~~~~tf
# AWS EC2 Instance Terraform Variables
# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "AWS EC2 Private Instances Count"
  type = number
  default = 1  
}
~~~~