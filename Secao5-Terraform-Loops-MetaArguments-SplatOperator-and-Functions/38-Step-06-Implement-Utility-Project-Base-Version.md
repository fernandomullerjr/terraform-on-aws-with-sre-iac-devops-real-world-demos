
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "38. Step-06: Implement Utility Project Base Version."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 38. Step-06: Implement Utility Project Base Version

<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/05-Terraform-Loops-MetaArguments-SplatOperator/05-03-Utility-Project>

# Terraform Small Utility Project 

## Step-01: Introduction
### Current Problem: 
- We are not able to create EC2 Instances in all the subnets of our VPC which are spread across all availability zones in that region
### Approach to  a Solution:
- We need to find a solution to say that our desired EC2 Instance Type `example: t3.micro` is supported in that availability zone or not
- In simple terms, give me the availability zone list in a particular region where by desired EC2 Instance Type (t3.micro) is supported
### Why utility project?
- In Terraform, we should `not` go and try things directly in large code base. 
- First try your requirements in small chunks and integrate that to main code base.
- We are going to do the same now.


## Step-02: c1-versions.tf
- Hard-coded the region as we are not going to use any `variables.tf` in this utility project
```t
# Provider Block
provider "aws" {
  region  = "us-east-1"
}
```

## Step-03: c2-v1-get-instancetype-supported-per-az-in-a-region.tf
- We are first going to explore the datasource and it outputs
```t
# Determine which Availability Zones support your instance type
aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t3.micro --region us-east-1 --output table
```

### Step-03-01: Review / Create the datasource and its output
```t
# Datasource
data "aws_ec2_instance_type_offerings" "my_ins_type1" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = ["us-east-1a"]
    #values = ["us-east-1e"]    
  }
  location_type = "availability-zone"
}

# Output
output "output_v1_1" {
 value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}
```

### Step-03-02: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
terraform apply -auto-approve
Observation: 
1. Output should have the instance value `t3.micro` when `values = ["us-east-1a"]` in location filter
# Sample Output
output_v1_1 = toset([
  "t3.micro",
])

# Make a change
Switch the values in `location` filter to `values = ["us-east-1e"]` and test again with `terraform plan`

# Terraform Plan
terraform plan
terraform apply -auto-approve
Observation: 
1. Output should have the instance value empty `[]` when `values = ["us-east-1e"]` in location filter
# Sample Output
output_v1_1 = toset([])
```


# ############################################################################
# ############################################################################
# ############################################################################
# 38. Step-06: Implement Utility Project Base Version

- OBS:
Esta aula é voltada para o exemplo do curso, onde a familia t3.micro apresenta alguns erros, pois ela não está disponível na AZ "us-east-1e", por exemplo.
Já a familia t2.micro que eu vinha usando, ela está disponível em todas as AZ's.


- Criando os manifestos nesta pasta:
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/utility-project/terraform-manifests

- Executando o comando abaixo, para ver a listagem de AZ que suportam a familia de instancia EC2:

```bash
# Determine which Availability Zones support your instance type
aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t3.micro --region us-east-1 --output table
```

- Resultado:

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$ aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t3.micro --region us-east-1 --output table
-------------------------------------------------------
|            DescribeInstanceTypeOfferings            |
+-----------------------------------------------------+
||               InstanceTypeOfferings               ||
|+--------------+--------------+---------------------+|
|| InstanceType |  Location    |    LocationType     ||
|+--------------+--------------+---------------------+|
||  t3.micro    |  us-east-1b  |  availability-zone  ||
||  t3.micro    |  us-east-1d  |  availability-zone  ||
||  t3.micro    |  us-east-1a  |  availability-zone  ||
||  t3.micro    |  us-east-1f  |  availability-zone  ||
||  t3.micro    |  us-east-1c  |  availability-zone  ||
|+--------------+--------------+---------------------+|
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$ date
Sat 16 Mar 2024 10:15:11 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
~~~~



- Verificando agora a t2:

```bash
# Determine which Availability Zones support your instance type
aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t2.micro --region us-east-1 --output table
```


- Resultado:

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$ aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t2.micro --region us-east-1 --output table
-------------------------------------------------------
|            DescribeInstanceTypeOfferings            |
+-----------------------------------------------------+
||               InstanceTypeOfferings               ||
|+--------------+--------------+---------------------+|
|| InstanceType |  Location    |    LocationType     ||
|+--------------+--------------+---------------------+|
||  t2.micro    |  us-east-1d  |  availability-zone  ||
||  t2.micro    |  us-east-1a  |  availability-zone  ||
||  t2.micro    |  us-east-1f  |  availability-zone  ||
||  t2.micro    |  us-east-1c  |  availability-zone  ||
||  t2.micro    |  us-east-1e  |  availability-zone  ||
||  t2.micro    |  us-east-1b  |  availability-zone  ||
|+--------------+--------------+---------------------+|
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$ date
Sat 16 Mar 2024 10:16:01 PM -03
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$
~~~~




- Iremos utilizar o data source "aws_ec2_instance_type_offerings", para obter as familias de EC2 ofertadas na região e AZ's:

```tf
# Datasource
data "aws_ec2_instance_type_offerings" "my_ins_type1" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = ["us-east-1a"]
    #values = ["us-east-1e"]    
  }
  location_type = "availability-zone"
}

# Output
output "output_v1_1" {
 value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}
```




- Testando o código, validando se a familia é ofertada na "us-east-1a":

  filter {
    name   = "location"
    values = ["us-east-1a"]
    #values = ["us-east-1e"]    
  }

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/utility-project/testes-especificos$ terraform plan
data.aws_ec2_instance_type_offerings.my_ins_type1: Reading...
data.aws_ec2_instance_type_offerings.my_ins_type1: Read complete after 1s [id=us-east-1]

Changes to Outputs:
  + output_v1_1 = [
      + "t3.micro",
    ]

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
~~~~




- Testando o código, validando se a familia é ofertada na "us-east-1e":

  filter {
    name   = "location"
    #values = ["us-east-1a"]
    values = ["us-east-1e"]    
  }

~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/utility-project/testes-especificos$ terraform plan
data.aws_ec2_instance_type_offerings.my_ins_type1: Reading...
data.aws_ec2_instance_type_offerings.my_ins_type1: Read complete after 1s [id=us-east-1]

Changes to Outputs:
  + output_v1_1 = []

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
~~~~

Retornou vazio o output.