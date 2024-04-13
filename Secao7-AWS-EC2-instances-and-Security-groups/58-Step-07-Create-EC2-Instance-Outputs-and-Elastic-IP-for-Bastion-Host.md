
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "58. Step-07: Create EC2 Instance Outputs and Elastic IP for Bastion Host."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  58. Step-07: Create EC2 Instance Outputs and Elastic IP for Bastion Host

### Step-06-04: c7-02-ec2instance-outputs.tf

```tf
# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}
output "ec2_bastion_public_ip" {
  description = "List of Public ip address assigned to the instances"
  value       = module.ec2_public.public_ip
}
# Private EC2 Instances
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private.id
}
output "ec2_private_ip" {
  description = "List of private ip address assigned to the instances"
  value       = module.ec2_private.private_ip
}
```


## Step-07: EC2 Elastic IP for Bastion Host - c8-elasticip.tf

- learn about [Terraform Resource Meta-Argument `depends_on`](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

```tf
# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public]
  instance =  module.ec2_public.id[0] 
  vpc = true
  tags = local.common_tags  
}
```