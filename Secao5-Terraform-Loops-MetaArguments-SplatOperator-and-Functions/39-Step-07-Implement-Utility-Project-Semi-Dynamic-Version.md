
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "39. Step-07: Implement Utility Project Semi Dynamic Version."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 39. Step-07: Implement Utility Project Semi Dynamic Version

- Vamos usar o for_each para fazer a versão semi-dinamica.

## Step-04: c2-v2-get-instancetype-supported-per-az-in-a-region.tf
- Using `for_each` create multiple instances of datasource and loop it with hard-coded availability zones in `for_each`
### Step-04-01: Review / Create the datasource and its output with for_each
```t
# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset([ "us-east-1a", "us-east-1e" ])
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}


# Important Note: Once for_each is set, its attributes must be accessed on specific instances
output "output_v2_1" {
 #value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
 value = toset([
      for t in data.aws_ec2_instance_type_offerings.my_ins_type2 : t.instance_types
    ])  
}

# Create a Map with Key as Availability Zone and value as Instance Type supported
output "output_v2_2" {
 value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2 :
  az => details.instance_types }   
}
```

### Step-04-02: Execute Terraform Commands
```t
# Terraform Plan
terraform plan
terraform apply -auto-approve
Observation: refer sample output
# Sample Output
output_v2_1 = toset([
  toset([
    "t3.micro",
  ]),
  toset([]),
])
output_v2_2 = {
  "us-east-1a" = toset([
    "t3.micro",
  ])
  "us-east-1e" = toset([])
}
```




# ############################################################################
# ############################################################################
# ############################################################################
# 39. Step-07: Implement Utility Project Semi Dynamic Version

- Vamos usar o for_each para fazer a versão semi-dinamica.

- Iremos utilizar este código:

~~~~tf
# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
# Datasource
data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset([ "us-east-1a", "us-east-1b", "us-east-1e" ])
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}


#Output-1
# Important Note: Once for_each is set, its attributes must be accessed on specific instances
output "output_v2_1" {
  #value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
  value = toset([for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types])
}

#Output-2
# Create a Map with Key as Availability Zone and value as Instance Type supported
output "output_v2_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
  }
}
~~~~


## PENDENTE
- Ver melhor sobre o trecho do for
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types