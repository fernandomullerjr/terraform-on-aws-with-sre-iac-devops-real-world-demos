
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "11. Step-07: Update Terraform manifest with AMI ID and Region."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
#  11. Step-07: Update Terraform manifest with AMI ID and Region


<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/02-Terraform-Basics/02-02-Terraform-Command-Basics>


Description
Amazon Linux 2023 AMI 2023.3.20240205.2 x86_64 HVM kernel-6.1
Architecture
Boot mode

uefi-preferred
AMI ID
ami-0e731c8a588258d0d