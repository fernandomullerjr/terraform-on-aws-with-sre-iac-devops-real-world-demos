
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

    hcl

output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

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




Dia 09/03/2024



# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Cada iteração do "instance" no List, pega um valor e adiciona a lista.

- Ao utilizar o map, o "instance.id => instance.public_dns" é um key:value, onde a Key é o instance id:
    {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}