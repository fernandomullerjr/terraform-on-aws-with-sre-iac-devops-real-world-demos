
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "36. Step-04: Implement AZ Datasource and for_each Meta-Argument."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 36. Step-04: Implement AZ Datasource and for_each Meta-Argument

- Página sobre esta parte da seção:
<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/05-Terraform-Loops-MetaArguments-SplatOperator/05-02-MetaArgument-for_each>

# Terraform for_each Meta-Argument with Functions toset, tomap
## Step-00: Pre-requisite Note
- We are using the `default vpc` in `us-east-1` region

## Step-01: Introduction
- `for_each` Meta-Argument
- `toset` function
- `tomap` function
- Data Source: aws_availability_zones

## Step-02: No changes to files
- c1-versions.tf
- c2-variables.tf
- c3-ec2securitygroups.tf
- c4-ami-datasource.tf

## Step-03: c5-ec2instance.tf
- To understand more about [for_each](https://www.terraform.io/docs/language/meta-arguments/for_each.html)

### Step-03-01: Availability Zones Datasource
```tf
# Availability Zones Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```








# ############################################################################
# ############################################################################
# ############################################################################
# 36. Step-04: Implement AZ Datasource and for_each Meta-Argument

## Data Source: aws_availability_zones

<https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones>


- Vamos trabalhar editando o manifesto de instance:
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests/c5-ec2instance.tf

- Por exemplo, se a VPC tem 6 AZ's, usando o for_each, conseguimos definir o parametro sobre AZ e criar 1 instancia EC2 em cada um dos AZ's.


- Vamos precisar saber os AZ's, para isto vamos usar o código do Data Source:


```tf
# Availability Zones Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```



- De acordo com a "Attribute Reference" na página do Data Source, temos o "names" que retorna os nomes dos AZ disponiveis na conta:
<https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones>
Attribute Reference

This data source exports the following attributes in addition to the arguments above:

    group_names A set of the Availability Zone Group names. For Availability Zones, this is the same value as the Region name. For Local Zones, the name of the associated group, for example us-west-2-lax-1.
    id - Region of the Availability Zones.
    names - List of the Availability Zone names available to the account.

- Podemos referenciar desta maneira:
data.aws_availability_zones.my_azones.names




##  for_each

<https://developer.hashicorp.com/terraform/language/meta-arguments/for_each>

for_each is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. 

- Usando algo neste formato, vai falhar, porque retorna uma lista, que não é suportado no 
    for_each = [data.aws_availability_zones.my_azones.names]

- Então podemos fazer uso da função "toset":
<https://developer.hashicorp.com/terraform/language/functions/toset>



## toset Function

toset converts its argument to a set value.

Explicit type conversions are rarely necessary in Terraform because it will convert types automatically where required. Use the explicit type conversion functions only to normalize types returned in module outputs.

Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.






- Código de referência, utilizando o for_each, toset, etc:

### Step-03-02: EC2 Instance Resource

```tf
# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  # Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key # You can also use each.value because for list items each.key == each.value
  tags = {
    "Name" = "For-Each-Demo-${each.key}"
  }
}
```





- Ajustando o manifesto

comentando o count
comentando as tags do count

adicionando:

~~~~t
  # Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key # You can also use each.value because for list items each.key == each.value
  tags = {
    "Name" = "For-Each-Demo-${each.key}"
  }
~~~~



- Efetuando plan

erro

~~~~bash

│ Error: Unsupported attribute
│
│   on c6-outputs.tf line 45, in output "latest_splat_instance_publicdns":
│   45:   value = aws_instance.myec2vm[*].public_dns
│
│ This object does not have an attribute named "public_dns".
╵

~~~~






# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- for_each funciona com map ou strings, não funciona com listas.

- A função toset consegue converter listas em set.

- Coleção do set não é ordenada.
- Valores duplicados são eliminados.

- No caso do set, o "each.key" equivale ao "each.value", devido a lista de items.
