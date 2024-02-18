
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "25. Step-01: Introduction to Variables Section."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 25. Step-01: Introduction to Variables Section

Terraform Variables and Datasources
Step-00: Pre-requisite Note

    Create a terraform-key in AWS EC2 Key pairs which we will reference in our EC2 Instance

Step-01: Introduction
Terraform Concepts

    Terraform Input Variables
    Terraform Datasources
    Terraform Output Values


## What are we going to learn ?

    Learn about Terraform Input Variable basics

    AWS Region
    Instance Type
    Key Name

    Define Security Groups and Associate them as a List item to AWS EC2 Instance

    vpc-ssh
    vpc-web

    Learn about Terraform Output Values

    Public IP
    Public DNS

    Get latest EC2 AMI ID Using Terraform Datasources concept
    We are also going to use existing EC2 Key pair terraform-key
    Use all the above to create an EC2 Instance in default VPC
