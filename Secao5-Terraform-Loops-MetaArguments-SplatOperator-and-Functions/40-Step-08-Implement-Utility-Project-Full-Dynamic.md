
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "40. Step-08: Implement Utility Project Full Dynamic Version with filtered output."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 40. Step-08: Implement Utility Project Full Dynamic Version with filtered output


## Step-05: c2-v3-get-instancetype-supported-per-az-in-a-region.tf

### Step-05-01: Add new datasource aws_availability_zones
- Get List of Availability Zones in a Specific Region
```t
# Get List of Availability Zones in a Specific Region
# Region is set in c1-versions.tf in Provider Block
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```

### Step-05-02: Update for_each with new datasource
```t
# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
data "aws_ec2_instance_type_offerings" "my_ins_type" {
for_each=toset(data.aws_availability_zones.my_azones.names)
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
```

### Step-05-03: Implement Incremental Outputs till we reach what is required
```t
# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_v3_1" {
 value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types }   
}

# Filtered Output: Exclude Unsupported Availability Zones
output "output_v3_2" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 }
}

# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v3_3" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 }) 
}

# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3_4" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 })[0]
}
```

### Step-05-04: Execute Terraform Commands
```t
# Terraform Plan
terraform plan
terraform appy -auto-approve
Observation: refer sample output
1. In the final output you will only get the availability zones list in which `t3.micro` instance is supported
# Sample Output
output_v3_1 = {
  "us-east-1a" = toset([
    "t3.micro",
  ])
  "us-east-1b" = toset([
    "t3.micro",
  ])
  "us-east-1c" = toset([
    "t3.micro",
  ])
  "us-east-1d" = toset([
    "t3.micro",
  ])
  "us-east-1e" = toset([])
  "us-east-1f" = toset([
    "t3.micro",
  ])
}
output_v3_2 = {
  "us-east-1a" = toset([
    "t3.micro",
  ])
  "us-east-1b" = toset([
    "t3.micro",
  ])
  "us-east-1c" = toset([
    "t3.micro",
  ])
  "us-east-1d" = toset([
    "t3.micro",
  ])
  "us-east-1f" = toset([
    "t3.micro",
  ])
}
output_v3_3 = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
  "us-east-1d",
  "us-east-1f",
]
output_v3_4 = "us-east-1a"
```

## Step-06: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```





# ############################################################################
# ############################################################################
# ############################################################################
# 40. Step-08: Implement Utility Project Full Dynamic Version with filtered output

- Vamos começar pelo trecho de AZ, que está com valores fixos manuais:

  for_each = toset([ "us-east-1a", "us-east-1b", "us-east-1e" ])


- Com o Datasource-1, vamos obter os AZ dinamicamente:

~~~~tf
# Datasource-1
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
~~~~


- Que podem ser referenciados desta forma:

  for_each = toset(data.aws_availability_zones.my_azones.names)




- Usando o Output-1, ele retorna até os AZ que não suportam a familia de EC2:


~~~~tf
# Output-1
# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_v3_1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types
  }
}
~~~~

- Resultado do output dele:

~~~~bash
 + output_v3_1 = {
      + us-east-1a = [
          + "t3.micro",
        ]
      + us-east-1b = [
          + "t3.micro",
        ]
      + us-east-1c = [
          + "t3.micro",
        ]
      + us-east-1d = [
          + "t3.micro",
        ]
      + us-east-1e = []
      + us-east-1f = [
          + "t3.micro",
        ]
    }
~~~~





- Para trazer no output apenas os AZ que suportam a familia de EC2, podemos utilizar uma condição if que retorna apenas os valores diferentes de 0:

~~~~tf
# Output-2
# Filtered Output: Exclude Unsupported Availability Zones
output "output_v3_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
    az => details.instance_types if length(details.instance_types) != 0 }
}
~~~~

- O resultado é este output:

~~~~bash
 + output_v3_2 = {
      + us-east-1a = [
          + "t3.micro",
        ]
      + us-east-1b = [
          + "t3.micro",
        ]
      + us-east-1c = [
          + "t3.micro",
        ]
      + us-east-1d = [
          + "t3.micro",
        ]
      + us-east-1f = [
          + "t3.micro",
        ]
    }
~~~~







- Caso queira retornar apenas as keys, é possível utilizando a função "keys":

<https://developer.hashicorp.com/terraform/language/functions/keys>
keys Function

keys takes a map and returns a list containing the keys from that map.

The keys are returned in lexicographical order, ensuring that the result will be identical as long as the keys in the map don't change.
Examples

> keys({a=1, c=2, d=3})
[
  "a",
  "c",
  "d",
]


- Código do Output-3, que traz somente as chaves:

~~~~tf
# Output-3
# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v3_3" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
    az => details.instance_types if length(details.instance_types) != 0 })
}
~~~~

- Isto resulta um output mais limpo, somente com os AZ's:

~~~~bash
 + output_v3_3 = [
      + "us-east-1a",
      + "us-east-1b",
      + "us-east-1c",
      + "us-east-1d",
      + "us-east-1f",
    ]
~~~~






- Caso queira trazer apenas o valor de 1 chave da listagem, basta colocar [0] ao final do código:

~~~~tf
# Output-4 (additional learning)
# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3_4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
    az => details.instance_types if length(details.instance_types) != 0 })[0]
}
~~~~

- Resultado do output com 1 valor apenas:

~~~~bash
 + output_v3_4 = "us-east-1a"
~~~~




## Step-06: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```



- Efetuando limpezas em pastas.
- Destroys

~~~~bash
Plan: 0 to add, 0 to change, 1 to destroy.

Changes to Outputs:
  - aws_account_id        = "058264180843" -> null
  - s3_bucket_arn         = "arn:aws:s3:::day67taskbucket-sandbox" -> null
  - s3_bucket_domain_name = "day67taskbucket-sandbox.s3.amazonaws.com" -> null
  - s3_bucket_id          = "day67taskbucket-sandbox" -> null
  - s3_bucket_region      = "us-east-1" -> null
aws_s3_bucket.my_bucket: Destroying... [id=day67taskbucket-sandbox]
aws_s3_bucket.my_bucket: Destruction complete after 1s

Destroy complete! Resources: 1 destroyed.
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$ rm -rf .terraform*
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$ rm -rf terraform.tfstate*
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$
~~~~




# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Para trazer no output apenas os AZ que suportam a familia de EC2, podemos utilizar uma condição if que retorna apenas os valores diferentes de 0:
    az => details.instance_types if length(details.instance_types) != 0 }

- Caso queira retornar apenas as keys, é possível utilizando a função "keys":
    <https://developer.hashicorp.com/terraform/language/functions/keys>
    Basta utilizar keys e colocar entre parenteses os key:value que serão considerados:
    keys()