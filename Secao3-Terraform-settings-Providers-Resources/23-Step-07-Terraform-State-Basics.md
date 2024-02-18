
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "23. Step-07: Terraform State Basics."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 23. Step-07: Terraform State Basics

Step-08: Terraform State - Basics

    Understand about Terraform State
    Terraform State file terraform.tfstate
    Understand about Desired State and Current State



You should store your state files remotely, not on your local machine! The location of the remote state file can then be referenced using a backendblock in the terraform block (which is usually in the main.tf file).

The example below shows a configuration using a storage account in Azure:

~~~~tf
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformsa"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}
~~~~