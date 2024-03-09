
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "34. Step-02: Implement Outputs with For Loops and Splat Operators."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 34. Step-02: Implement Outputs with For Loops and Splat Operators


Step-06: c6-outputs.tf

    for loop with List
    for loop with Map
    for loop with Map Advanced

~~~~tf
# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
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

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.myec2vm[*].public_dns
}
~~~~











I'll explain the use of lists and maps in the given Terraform outputs, as well as the functionality of each part of the for expressions:

## Output - For Loop with List:

Purpose: Creates a list of public DNS names for all instances in the aws_instance.myec2vm resource.

Breakdown:

    [ and ]: Enclose a list, similar to arrays in other languages.
    for instance in aws_instance.myec2vm:: Iterates through each instance in the aws_instance.myec2vm resource.
    instance.public_dns: Accesses the public_dns attribute of the current instance in each iteration, appending it to the list.

## Output - For Loop with Map:

Purpose: Creates a map (key-value pairs) associating instance IDs with their corresponding public DNS names.

Breakdown:

    { and }: Enclose a map, similar to dictionaries or objects in other languages.
    for instance in aws_instance.myec2vm:: Iterates through each instance again.
    instance.id => instance.public_dns: Creates a key-value pair within the map:
        instance.id: Key, using the instance ID.
        =>: Assignment operator for maps.
        instance.public_dns: Value, the public DNS name of the current instance.

Key Points:

    The for expression iterates over a collection (list or map) and generates a new collection with modified or derived values.
    Lists store ordered sequences of elements, accessed by index.
    Maps store key-value pairs, accessed by key.
    Terraform outputs allow you to expose values for external consumption or reference in other parts of your configuration.

When to Use:

    Use lists when you need to preserve order or access elements by index.
    Use maps when you need to associate values with unique keys for lookup.







ChatGPT

Esses são exemplos de como usar a função for em Terraform para iterar sobre recursos e criar listas ou mapas com base nos atributos desses recursos. Vamos analisar cada parte:

    Output - For Loop with List:

~~~~tf
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}
~~~~

    aws_instance.myec2vm: Isso presume que você tenha definido um recurso do tipo aws_instance com o nome myec2vm anteriormente em seu código Terraform. Este recurso provavelmente cria uma ou mais instâncias EC2 na AWS.
    for instance in aws_instance.myec2vm: Isso itera sobre todas as instâncias EC2 criadas pelo recurso aws_instance.myec2vm.
    instance.public_dns: Para cada instância EC2, isso obtém o seu DNS público.
    [for instance in aws_instance.myec2vm: instance.public_dns]: Isso cria uma lista contendo o DNS público de todas as instâncias EC2.

Output - For Loop with Map:

hcl

    output "for_output_map1" {
      description = "For Loop with Map"
      value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
    }

        aws_instance.myec2vm: Da mesma forma que antes, isso presume que você tenha definido um recurso do tipo aws_instance com o nome myec2vm.
        for instance in aws_instance.myec2vm: Isso itera sobre todas as instâncias EC2 criadas pelo recurso aws_instance.myec2vm.
        instance.id => instance.public_dns: Para cada instância EC2, isso cria uma entrada no mapa onde a chave é o ID da instância e o valor é o seu DNS público.

Em resumo, ambos os exemplos usam a função for do Terraform para iterar sobre recursos e criar estruturas de dados (lista ou mapa) com base nos atributos desses recursos. Isso é útil para extrair informações específicas dos recursos criados e usá-las em outras partes do código Terraform ou para produzir saídas úteis.






## PENDENTE
- Video continua em
05:24





## Dia 09/03/2024


- Video continua em
05:24

~~~~tf
# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

~~~~


Este trecho de código em Terraform é um exemplo de como usar a função for em conjunto com um mapa (map) para iterar sobre os recursos criados em uma configuração Terraform e extrair informações específicas de cada recurso.  
 
    value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}: Aqui está a parte mais importante. Esta é a expressão for, que itera sobre os recursos do tipo aws_instance.myec2vm. Para cada instância de aws_instance (representada por instance), estamos coletando duas informações: c (chave) e instance.public_dns (valor). Isso cria um mapa onde as chaves são as chaves de cada instância aws_instance e os valores são os DNS públicos dessas instâncias.

No geral, este trecho de código gera uma saída que contém um mapa onde as chaves são as chaves das instâncias EC2 e os valores são os DNS públicos dessas instâncias. Isso pode ser útil, por exemplo, para recuperar informações específicas de recursos criados pelo Terraform e usá-las em outros lugares de sua infraestrutura ou em processos de automação.







Context:

    Output Block: The code resides within an output block, designed to display Terraform-managed values as output after execution.
    For Loop: It employs a for loop to iterate over a collection of AWS EC2 instances.
    Map Construction: The loop constructs a map data structure, associating instance names with their public DNS addresses.

2.  Loop Breakdown:

    Loop Syntax:
    Terraform

    for c, instance in aws_instance.myec2vm:

        c: A temporary variable holding the instance name (key) during each iteration.
        instance: A temporary variable representing the entire instance object during each iteration.
        aws_instance.myec2vm: References a resource collection of EC2 instances, likely defined elsewhere in the code.

3.  Map Creation:

    value = { for c, instance in aws_instance.myec2vm: c => instance.public_dns }:
        Iterates over each instance in the aws_instance.myec2vm collection.
        For each instance:
            Stores the instance name (c) as the key in the map.
            Stores the instance's public DNS address (instance.public_dns) as the corresponding value in the map.







- Testando

criando 2 instancias EC2

~~~~BASH

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + for_output_list                 = [
      + (known after apply),
      + (known after apply),
    ]
  + for_output_map1                 = (known after apply)
  + for_output_map2                 = {
      + "0" = (known after apply)
      + "1" = (known after apply)
    }
  + latest_splat_instance_publicdns = [
      + (known after apply),
      + (known after apply),
    ]
aws_security_group.vpc-ssh: Creating...
aws_security_group.vpc-web: Creating...
aws_security_group.vpc-web: Creation complete after 5s [id=sg-074cade9bf50e9470]
aws_security_group.vpc-ssh: Creation complete after 5s [id=sg-0884c7594474119db]
aws_instance.myec2vm[0]: Creating...
aws_instance.myec2vm[1]: Creating...
aws_instance.myec2vm[0]: Still creating... [10s elapsed]
aws_instance.myec2vm[1]: Still creating... [10s elapsed]
aws_instance.myec2vm[0]: Still creating... [20s elapsed]
aws_instance.myec2vm[1]: Still creating... [20s elapsed]
aws_instance.myec2vm[1]: Still creating... [30s elapsed]
aws_instance.myec2vm[0]: Still creating... [30s elapsed]
aws_instance.myec2vm[0]: Creation complete after 34s [id=i-04c2d7e4cd7b71315]
aws_instance.myec2vm[1]: Creation complete after 34s [id=i-03da75a55430e70d7]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

for_output_list = [
  "ec2-54-159-136-235.compute-1.amazonaws.com",
  "ec2-54-205-29-71.compute-1.amazonaws.com",
]
for_output_map1 = {
  "i-03da75a55430e70d7" = "ec2-54-205-29-71.compute-1.amazonaws.com"
  "i-04c2d7e4cd7b71315" = "ec2-54-159-136-235.compute-1.amazonaws.com"
}
for_output_map2 = {
  "0" = "ec2-54-159-136-235.compute-1.amazonaws.com"
  "1" = "ec2-54-205-29-71.compute-1.amazonaws.com"
}
latest_splat_instance_publicdns = [
  "ec2-54-159-136-235.compute-1.amazonaws.com",
  "ec2-54-205-29-71.compute-1.amazonaws.com",
]
You have new mail in /var/mail/fernando
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao5-Terraform-Loops-MetaArguments-SplatOperator-and-Functions/terraform-manifests$

~~~~



# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Cada iteração do "instance" no List, pega um valor e adiciona a lista.
    value = [for instance in aws_instance.myec2vm: instance.public_dns ]

- Ao utilizar o map, o "instance.id => instance.public_dns" é um key:value, onde a Key é o instance id:
    {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}

- Neste exemplo o "c" representa um valor único, que é definido como chave neste map. Neste caso ele pega um valor como identificador único e atribui a esta chave:
    value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}