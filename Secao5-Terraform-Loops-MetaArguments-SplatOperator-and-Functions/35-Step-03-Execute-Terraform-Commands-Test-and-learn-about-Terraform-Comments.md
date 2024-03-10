
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "35. Step-03: Execute Terraform Commands, Test and learn about Terraform Comments."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 35. Step-03: Execute Terraform Commands, Test and learn about Terraform Comments

# Step-07: Execute Terraform Commands

## Terraform Initialize
terraform init

## Terraform Validate
terraform validate

## Terraform Plan
terraform plan
Observations: 
1) play with Lists and Maps for instance_type

## Terraform Apply
terraform apply -auto-approve
Observations: 
1) Two EC2 Instances (Count = 2) of a Resource myec2vm will be created
2) Count.index will start from 0 and end with 1 for VM Names
3) Review outputs in detail (for loop with list, maps, maps advanced, splat legacy and splat latest)



# Step-08: Terraform Comments

    Single Line Comments - # and //
    Multi-line Commnets - Start with /* and end with */
    We are going to comment the legacy splat operator, which might be decommissioned in future versions

~~~~tf
# Output Legacy Splat Operator (latest) - Returns the List
/* output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  */
~~~~




# Step-09: Clean-Up

## Terraform Destroy
terraform destroy -auto-approve

## Files
rm -rf .terraform*
rm -rf terraform.tfstate*





# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Formas de criar comentários no Terraform:

    Single Line Comments - # and //
    Multi-line Commnets - Start with /* and end with */