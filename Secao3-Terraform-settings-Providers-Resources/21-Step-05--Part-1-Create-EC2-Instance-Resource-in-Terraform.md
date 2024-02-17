
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "21. Step-05: Part-1: Create EC2 Instance Resource in Terraform."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 21. Step-05: Part-1: Create EC2 Instance Resource in Terraform

Step-04: In c2-ec2instance.tf - Create Resource Block

    Understand about Resources
    Create EC2 Instance Resource
    Understand about File Function
    Understand about Resources - Argument Reference
    Understand about Resources - Attribute Reference

~~~~tf
# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
~~~~