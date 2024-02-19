
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "29. Step-05: Create AMI Datasource Resource."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 29. Step-05: Create AMI Datasource Resource

Step-04: c4-ami-datasource.tf - Define Get Latest AMI ID for Amazon Linux2 OS

    Data Source: aws_ami

~~~~tf
# Get latest AMI ID for Amazon Linux2 OS
# Get Latest AWS AMI ID for Amazon2 Linux
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
~~~~

    Reference the datasource in c5-ec2instance.tf file

# Reference Datasource to get the latest AMI ID
ami = data.aws_ami.amzlinux2.id 







<https://developer.hashicorp.com/terraform/language/data-sources>

<https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami>