
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
