
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "37. Step-05: Implement Outputs with toset, tomap functions and create and destroy."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 37. Step-05: Implement Outputs with toset, tomap functions and create and destroy


## Step-04: c6-outputs.tf
```tf

# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  #value = aws_instance.myec2vm.*.public_ip   # Legacy Splat
  #value = aws_instance.myec2vm[*].public_ip  # Latest Splat
  value = toset([
      for myec2vm in aws_instance.myec2vm : myec2vm.public_ip
    ])  
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  #value = aws_instance.myec2vm[*].public_dns  # Legacy Splat
  #value = aws_instance.myec2vm[*].public_dns  # Latest Splat
  value = toset([
      for myec2vm in aws_instance.myec2vm : myec2vm.public_dns
    ])    
}

# EC2 Instance Public DNS with MAPS
output "instance_publicdns2" {
  value = tomap({
    for s, myec2vm in aws_instance.myec2vm : s => myec2vm.public_dns
    # S intends to be a subnet ID
  })
}
```









# ############################################################################
# ############################################################################
# ############################################################################
# 37. Step-05: Implement Outputs with toset, tomap functions and create and destroy

- Acessando diretório dos manifestos:

cd /home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests


- Ao tentar fazer plan, ocorre erro:

~~~~bash
│ Error: Unsupported attribute
│
│   on c6-outputs.tf line 45, in output "latest_splat_instance_publicdns":
│   45:   value = aws_instance.myec2vm[*].public_dns
│
│ This object does not have an attribute named "public_dns".
╵
~~~~

Isto ocorre porque existe uso de Splat, que não funciona com o for_each!
Isto ocorre porque existe uso de Splat, que não funciona com o for_each!
Isto ocorre porque existe uso de Splat, que não funciona com o for_each!
Isto ocorre porque existe uso de Splat, que não funciona com o for_each!





## tomap Function

- Função tomap
<https://developer.hashicorp.com/terraform/language/functions/tomap>

tomap converts its argument to a map value.

Explicit type conversions are rarely necessary in Terraform because it will convert types automatically where required. Use the explicit type conversion functions only to normalize types returned in module outputs.
Examples

> tomap({"a" = 1, "b" = 2})
{
  "a" = 1
  "b" = 2
}

Since Terraform's concept of a map requires all of the elements to be of the same type, mixed-typed elements will be converted to the most general type:

> tomap({"a" = "foo", "b" = true})
{
  "a" = "foo"
  "b" = "true"
}





- Efetuando apply utilizando o formato abaixo, onde não tem o toset e tomap em uso:

~~~~tf

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}
~~~~


- Criou instancias EC2 em cada AZ e trouxe os outputs:

~~~~bash

aws_security_group.vpc-ssh: Creating...
aws_security_group.vpc-web: Creating...
aws_security_group.vpc-ssh: Creation complete after 4s [id=sg-01749b48993493ac2]
aws_security_group.vpc-web: Creation complete after 4s [id=sg-06c1957dd871828b3]
aws_instance.myec2vm["us-east-1b"]: Creating...
aws_instance.myec2vm["us-east-1f"]: Creating...
aws_instance.myec2vm["us-east-1d"]: Creating...
aws_instance.myec2vm["us-east-1a"]: Creating...
aws_instance.myec2vm["us-east-1e"]: Creating...
aws_instance.myec2vm["us-east-1c"]: Creating...
aws_instance.myec2vm["us-east-1b"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1f"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1d"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1a"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1c"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1e"]: Still creating... [10s elapsed]
aws_instance.myec2vm["us-east-1b"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1f"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1d"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1e"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1a"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1c"]: Still creating... [20s elapsed]
aws_instance.myec2vm["us-east-1e"]: Creation complete after 24s [id=i-012e7871b25072eb0]
aws_instance.myec2vm["us-east-1f"]: Still creating... [30s elapsed]
aws_instance.myec2vm["us-east-1b"]: Still creating... [30s elapsed]
aws_instance.myec2vm["us-east-1d"]: Still creating... [30s elapsed]
aws_instance.myec2vm["us-east-1c"]: Still creating... [30s elapsed]
aws_instance.myec2vm["us-east-1a"]: Still creating... [30s elapsed]
aws_instance.myec2vm["us-east-1b"]: Creation complete after 34s [id=i-0e9720a8832f886c0]
aws_instance.myec2vm["us-east-1c"]: Creation complete after 34s [id=i-01979634445b03027]
aws_instance.myec2vm["us-east-1f"]: Creation complete after 35s [id=i-0225b2edd75d6f3ca]
aws_instance.myec2vm["us-east-1a"]: Creation complete after 35s [id=i-0b110624fc2f4da15]
aws_instance.myec2vm["us-east-1d"]: Still creating... [40s elapsed]
aws_instance.myec2vm["us-east-1d"]: Creation complete after 44s [id=i-030e5acfc5eb8fad0]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

for_output_list = [
  "ec2-54-83-94-65.compute-1.amazonaws.com",
  "ec2-34-229-102-67.compute-1.amazonaws.com",
  "ec2-44-193-75-122.compute-1.amazonaws.com",
  "ec2-34-207-88-85.compute-1.amazonaws.com",
  "ec2-3-84-238-227.compute-1.amazonaws.com",
  "ec2-18-207-251-113.compute-1.amazonaws.com",
]
for_output_map1 = {
  "i-012e7871b25072eb0" = "ec2-3-84-238-227.compute-1.amazonaws.com"
  "i-01979634445b03027" = "ec2-44-193-75-122.compute-1.amazonaws.com"
  "i-0225b2edd75d6f3ca" = "ec2-18-207-251-113.compute-1.amazonaws.com"
  "i-030e5acfc5eb8fad0" = "ec2-34-207-88-85.compute-1.amazonaws.com"
  "i-0b110624fc2f4da15" = "ec2-54-83-94-65.compute-1.amazonaws.com"
  "i-0e9720a8832f886c0" = "ec2-34-229-102-67.compute-1.amazonaws.com"
}
for_output_map2 = {
  "us-east-1a" = "ec2-54-83-94-65.compute-1.amazonaws.com"
  "us-east-1b" = "ec2-34-229-102-67.compute-1.amazonaws.com"
  "us-east-1c" = "ec2-44-193-75-122.compute-1.amazonaws.com"
  "us-east-1d" = "ec2-34-207-88-85.compute-1.amazonaws.com"
  "us-east-1e" = "ec2-3-84-238-227.compute-1.amazonaws.com"
  "us-east-1f" = "ec2-18-207-251-113.compute-1.amazonaws.com"
}

~~~~



- Ajustando o outputs para o formato desta aula:

~~~~TF

### AULA 37
# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  #value = aws_instance.myec2vm.*.public_ip   # Legacy Splat
  #value = aws_instance.myec2vm[*].public_ip  # Latest Splat
  value = toset([
      for myec2vm in aws_instance.myec2vm : myec2vm.public_ip
    ])  
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  #value = aws_instance.myec2vm[*].public_dns  # Legacy Splat
  #value = aws_instance.myec2vm[*].public_dns  # Latest Splat
  value = toset([
      for myec2vm in aws_instance.myec2vm : myec2vm.public_dns
    ])    
}

# EC2 Instance Public DNS with MAPS
output "instance_publicdns2" {
  value = tomap({
    for s, myec2vm in aws_instance.myec2vm : s => myec2vm.public_dns
    # S intends to be a subnet ID
  })
}
~~~~



- Efetuando plan:

~~~~bash
aws_instance.myec2vm["us-east-1f"]: Refreshing state... [id=i-0225b2edd75d6f3ca]
aws_instance.myec2vm["us-east-1d"]: Refreshing state... [id=i-030e5acfc5eb8fad0]
aws_instance.myec2vm["us-east-1a"]: Refreshing state... [id=i-0b110624fc2f4da15]
aws_instance.myec2vm["us-east-1c"]: Refreshing state... [id=i-01979634445b03027]
aws_instance.myec2vm["us-east-1e"]: Refreshing state... [id=i-012e7871b25072eb0]
aws_instance.myec2vm["us-east-1b"]: Refreshing state... [id=i-0e9720a8832f886c0]

Changes to Outputs:
  - for_output_list     = [
      - "ec2-54-83-94-65.compute-1.amazonaws.com",
      - "ec2-34-229-102-67.compute-1.amazonaws.com",
      - "ec2-44-193-75-122.compute-1.amazonaws.com",
      - "ec2-34-207-88-85.compute-1.amazonaws.com",
      - "ec2-3-84-238-227.compute-1.amazonaws.com",
      - "ec2-18-207-251-113.compute-1.amazonaws.com",
    ] -> null
  - for_output_map1     = {
      - i-012e7871b25072eb0 = "ec2-3-84-238-227.compute-1.amazonaws.com"
      - i-01979634445b03027 = "ec2-44-193-75-122.compute-1.amazonaws.com"
      - i-0225b2edd75d6f3ca = "ec2-18-207-251-113.compute-1.amazonaws.com"
      - i-030e5acfc5eb8fad0 = "ec2-34-207-88-85.compute-1.amazonaws.com"
      - i-0b110624fc2f4da15 = "ec2-54-83-94-65.compute-1.amazonaws.com"
      - i-0e9720a8832f886c0 = "ec2-34-229-102-67.compute-1.amazonaws.com"
    } -> null
  - for_output_map2     = {
      - us-east-1a = "ec2-54-83-94-65.compute-1.amazonaws.com"
      - us-east-1b = "ec2-34-229-102-67.compute-1.amazonaws.com"
      - us-east-1c = "ec2-44-193-75-122.compute-1.amazonaws.com"
      - us-east-1d = "ec2-34-207-88-85.compute-1.amazonaws.com"
      - us-east-1e = "ec2-3-84-238-227.compute-1.amazonaws.com"
      - us-east-1f = "ec2-18-207-251-113.compute-1.amazonaws.com"
    } -> null
  + instance_publicdns  = [
      + "ec2-18-207-251-113.compute-1.amazonaws.com",
      + "ec2-3-84-238-227.compute-1.amazonaws.com",
      + "ec2-34-207-88-85.compute-1.amazonaws.com",
      + "ec2-34-229-102-67.compute-1.amazonaws.com",
      + "ec2-44-193-75-122.compute-1.amazonaws.com",
      + "ec2-54-83-94-65.compute-1.amazonaws.com",
    ]
  + instance_publicdns2 = {
      + us-east-1a = "ec2-54-83-94-65.compute-1.amazonaws.com"
      + us-east-1b = "ec2-34-229-102-67.compute-1.amazonaws.com"
      + us-east-1c = "ec2-44-193-75-122.compute-1.amazonaws.com"
      + us-east-1d = "ec2-34-207-88-85.compute-1.amazonaws.com"
      + us-east-1e = "ec2-3-84-238-227.compute-1.amazonaws.com"
      + us-east-1f = "ec2-18-207-251-113.compute-1.amazonaws.com"
    }
  + instance_publicip   = [
      + "18.207.251.113",
      + "3.84.238.227",
      + "34.207.88.85",
      + "34.229.102.67",
      + "44.193.75.122",
      + "54.83.94.65",
    ]
~~~~


- No video informa erro devido a AZ e a familia t3a.micro
como estou usando t2.micro, não tomei o erro sobre a AZ us-east-1e 
criou as EC2 em todas as AZ:

      + us-east-1a = "ec2-54-83-94-65.compute-1.amazonaws.com"
      + us-east-1b = "ec2-34-229-102-67.compute-1.amazonaws.com"
      + us-east-1c = "ec2-44-193-75-122.compute-1.amazonaws.com"
      + us-east-1d = "ec2-34-207-88-85.compute-1.amazonaws.com"
      + us-east-1e = "ec2-3-84-238-227.compute-1.amazonaws.com"
      + us-east-1f = "ec2-18-207-251-113.compute-1.amazonaws.com"




# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Splat não trabalha com for_each.

- Splat é usado principalmente para listas, conjuntos e tuplas, não para mapas ou recursos for_each.

- O meta-argumento for_each aceita um map ou um conjunto de strings e cria uma instância para cada item nesse map ou set.

- map requires all of the elements to be of the same type, mixed-typed elements will be converted to the most general type

- "tomap" é interessante quando os valores precisam ser do mesmo tipo.