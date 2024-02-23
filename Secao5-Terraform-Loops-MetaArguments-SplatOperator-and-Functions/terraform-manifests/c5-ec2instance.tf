# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.amzlinux2.id
  #instance_type          = var.instance_type

  
  # How to reference List values ?
  #instance_type = var.instance_type_list[1]

  # How to reference Map values ?
  instance_type = var.instance_type_map["dev"]

  user_data              = file("${path.module}/app1-install.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  # Meta-Argument Count
  count = 2

  # count.index
    tags = {
      "Name" = "EC2-Count-Demo-${count.index}"
    }

  # tags = {
  #   "Name" = "EC2 Demo 2"
  # }
}