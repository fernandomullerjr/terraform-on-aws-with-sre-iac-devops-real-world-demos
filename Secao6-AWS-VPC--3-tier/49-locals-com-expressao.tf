locals {
  subnet_ids = [
    for subnet in aws_subnets.public : subnet.id
  ]
}

resource "aws_instance" "web" {
  count = 2

  subnet_id = local.subnet_ids[count.index]

}