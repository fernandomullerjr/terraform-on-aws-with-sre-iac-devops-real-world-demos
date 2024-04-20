
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "63. Step-12: Verify EC2, VPC, SG and Connect with SSH."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  63. Step-12: Verify EC2, VPC, SG and Connect with SSH


- Plan

~~~~bash

module.ec2_private["1"].aws_instance.this[0]: Refreshing state... [id=i-0a79e9e3765dc238e]
aws_eip.bastion_eip: Refreshing state... [id=eipalloc-021447a51f9502d70]
null_resource.name: Refreshing state... [id=1416821790077800505]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.ec2_public.aws_instance.this[0] has changed
  ~ resource "aws_instance" "this" {
        id                                   = "i-05705c9d087c2a81d"
      + public_dns                           = "ec2-54-209-69-7.compute-1.amazonaws.com"
      + public_ip                            = "54.209.69.7"
        tags                                 = {
            "Name"        = "stag-BastionHost"
            "environment" = "stag"
            "owners"      = "HR"
        }
        # (31 unchanged attributes hidden)

        # (9 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Changes to Outputs:
  ~ ec2_bastion_public_ip           = "" -> "54.209.69.7"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

~~~~