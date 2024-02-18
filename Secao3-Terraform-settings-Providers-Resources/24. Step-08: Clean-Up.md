
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "24. Step-08: Clean-Up."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 24. Step-08: Clean-Up


Step-09: Clean-Up

# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*






terraform plan -destroy


- Limpando

~~~~bash

aws_instance.myec2vm: Destroying... [id=i-0d1c1dff3381b4f95]
aws_instance.myec2vm: Still destroying... [id=i-0d1c1dff3381b4f95, 10s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-0d1c1dff3381b4f95, 20s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-0d1c1dff3381b4f95, 30s elapsed]
aws_instance.myec2vm: Still destroying... [id=i-0d1c1dff3381b4f95, 40s elapsed]
aws_instance.myec2vm: Destruction complete after 44s

Destroy complete! Resources: 1 destroyed.
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ ls -lhasp
total 40K
4.0K drwxr-xr-x 3 fernando fernando 4.0K Feb 18 12:15 ./
4.0K drwxr-xr-x 3 fernando fernando 4.0K Feb 18 11:22 ../
4.0K -rw-r--r-- 1 fernando fernando 1.0K Feb 18 10:21 app1-install.sh
4.0K -rw-r--r-- 1 fernando fernando  354 Feb 17 16:05 c1-versions.tf
4.0K -rw-r--r-- 1 fernando fernando  215 Feb 17 16:02 ec2.tf
4.0K drwxr-xr-x 3 fernando fernando 4.0K Feb 17 16:08 .terraform/
4.0K -rw-r--r-- 1 fernando fernando 1.4K Feb 17 16:08 .terraform.lock.hcl
4.0K -rw-r--r-- 1 fernando fernando  181 Feb 18 12:15 terraform.tfstate
8.0K -rw-r--r-- 1 fernando fernando 4.8K Feb 18 12:15 terraform.tfstate.backup
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ rm -rf .terraform*
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ rm -rf terraform.tfstate*
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ ls -lhasp
total 20K
4.0K drwxr-xr-x 2 fernando fernando 4.0K Feb 18 12:19 ./
4.0K drwxr-xr-x 3 fernando fernando 4.0K Feb 18 11:22 ../
4.0K -rw-r--r-- 1 fernando fernando 1.0K Feb 18 10:21 app1-install.sh
4.0K -rw-r--r-- 1 fernando fernando  354 Feb 17 16:05 c1-versions.tf
4.0K -rw-r--r-- 1 fernando fernando  215 Feb 17 16:02 ec2.tf
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ date
Sun 18 Feb 2024 12:19:23 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$

~~~~