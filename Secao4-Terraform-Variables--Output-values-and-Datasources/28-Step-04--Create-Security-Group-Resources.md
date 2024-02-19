
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "28. Step-04: Create Security Group Resources."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
#  28. Step-04: Create Security Group Resources

Step-03: c3-ec2securitygroups.tf - Define Security Group Resources in Terraform

    Resource: aws_security_group

~~~~TF
# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev VPC web"
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
~~~~

    Reference the security groups in c5-ec2instance.tf file as a list item

# List Item
vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]  



- Formatando:

~~~~BASH
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao3-Terraform-settings-Providers-Resources/ec2-webserver$ cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ terraform fmt
c1-versions.tf
c2-variables.tf
c3-ec2securitygroups.tf
ec2.tf
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ date
Sun 18 Feb 2024 01:39:34 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ terraform fmt
c5-ec2instance.tf
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$ date
Sun 18 Feb 2024 01:44:53 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao4-Terraform-Variables--Output-values-and-Datasources/terraform-manifests$

~~~~



Se não é mencionada VPC no manifesto, o Terraform assume que o recurso vai ser criado na VPC Default.