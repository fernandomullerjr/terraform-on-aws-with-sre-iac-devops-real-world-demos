
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

Output - For Loop with List:

Purpose: Creates a list of public DNS names for all instances in the aws_instance.myec2vm resource.

Breakdown:

    [ and ]: Enclose a list, similar to arrays in other languages.
    for instance in aws_instance.myec2vm:: Iterates through each instance in the aws_instance.myec2vm resource.
    instance.public_dns: Accesses the public_dns attribute of the current instance in each iteration, appending it to the list.

Output - For Loop with Map:

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




# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Cada iteração do "instance" no List, pega um valor e adiciona a lista.