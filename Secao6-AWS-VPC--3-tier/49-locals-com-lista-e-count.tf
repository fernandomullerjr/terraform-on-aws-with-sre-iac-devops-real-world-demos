
# Provider Block
provider "aws" {
  region = "us-east-1"

  profile = "fernandomullerjunior-labs/AdministratorAccess"

}

locals {
  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.public.id,
    aws_subnet.private.id,
  ]
}


resource "aws_instance" "web" {
  count = 2

  #vpc_id = local.vpc_id
  subnet_id = local.subnet_ids[count.index]

}