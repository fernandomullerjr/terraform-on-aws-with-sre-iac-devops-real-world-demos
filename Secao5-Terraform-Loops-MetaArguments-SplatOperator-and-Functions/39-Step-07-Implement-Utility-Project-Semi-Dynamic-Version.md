
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


Neste código Terraform, os output são usados para expor informações sobre os recursos criados ou recuperados pelo Terraform durante a execução. Vamos analisar cada um dos output:

Output-1:

  Este output está usando uma lista de tipos de instância recuperados do recurso aws_ec2_instance_type_offerings. Aqui está como funciona:

      value: Utiliza uma expressão de compreensão de lista for para iterar sobre os tipos de instância retornados pelo recurso aws_ec2_instance_type_offerings.my_ins_type2. O resultado é uma lista de tipos de instância.

      toset(): Esta função converte a lista resultante da expressão de compreensão em um conjunto. Isso é útil se você deseja garantir que não haja duplicatas na lista de tipos de instância.

Output-2:

  Este output está criando um mapa onde a chave é a zona de disponibilidade (Availability Zone) e o valor é uma lista de tipos de instância suportados nessa zona. Aqui está como funciona:

      value: Utiliza uma expressão de compreensão de mapa for para iterar sobre as zonas de disponibilidade e os detalhes retornados pelo recurso aws_ec2_instance_type_offerings.my_ins_type2. O resultado é um mapa onde cada chave é uma zona de disponibilidade e o valor é uma lista de tipos de instância suportados nessa zona.

Ambos os output estão usando a mesma fonte de dados, data.aws_ec2_instance_type_offerings.my_ins_type2, mas eles formatam os dados de maneira diferente para atender a diferentes necessidades de saída. O primeiro output retorna uma lista de todos os tipos de instância, enquanto o segundo output retorna um mapa onde as chaves são as zonas de disponibilidade e os valores são as listas de tipos de instância suportados nessas zonas.







## PENDENTE
- Ver melhor sobre o trecho do for
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types

- Set para trazer de forma simples, sem saber o az atrelado? Map para conseguirmos ter chave:valor e saber o AZ?


User
como o terraform sabe que o "az" são as Availability Zone?
ChatGPT

No código Terraform fornecido, a chave az usada no for do output está sendo atribuída pelo usuário como um alias para representar cada uma das zonas de disponibilidade (Availability Zones) iteradas.

No contexto do código fornecido:

~~~~t
  for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2
~~~~

A expressão for az, details está iterando sobre os dados retornados pelo recurso data.aws_ec2_instance_type_offerings.my_ins_type2. Aqui, az é um alias definido pelo usuário que representa cada zona de disponibilidade iterada, enquanto details representa os detalhes associados a essa zona de disponibilidade, como os tipos de instância suportados.

Portanto, Terraform não "sabe" que az representa uma zona de disponibilidade por si só - isso é especificado pelo usuário no código. É uma convenção ou nome escolhido pelo usuário para referenciar os dados retornados de forma mais significativa dentro do contexto do código.


como ele sabe que az recebe as chaves?
ChatGPT

Em Terraform, quando você usa a sintaxe for key, value in map ou for index, element in list, Terraform automaticamente associa as variáveis key e value (ou index e element, respectivamente) às chaves e valores de um mapa ou lista, respectivamente.

No caso específico do output em questão:

~~~~tf
output "output_v2_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
  }
}
~~~~

O for az, details itera sobre os dados retornados por data.aws_ec2_instance_type_offerings.my_ins_type2, que presumivelmente são uma estrutura de dados onde cada chave representa uma zona de disponibilidade (Availability Zone) e cada valor são os detalhes associados a essa zona, como os tipos de instância suportados.

Assim, o Terraform associa automaticamente az às chaves do mapa retornado e details aos valores correspondentes. Isso é uma convenção de nomenclatura comum, mas você poderia nomear as variáveis key e value se preferisse:

~~~~tf
output "output_v2_2" {
  value = {
    for key, value in data.aws_ec2_instance_type_offerings.my_ins_type2: key => value.instance_types
  }
}
~~~~

Então, o Terraform sabe que az recebe as chaves porque você está iterando sobre um mapa e atribuindo um nome (no caso, az) para representar essas chaves dentro do loop for.







## Gemini

### Output-1 (output_v2_1):

~~~~tf
output "output_v2_1" {
  value = toset([for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types])
}
~~~~

    Functionality:
        Iterates over each element (t) in the data.aws_ec2_instance_type_offerings.my_ins_type2 data source.
        Extracts the instance_types attribute from each element (t).
        Creates a set using toset to remove duplicates.

    Output:
        A set containing all unique instance types offered for the specified regions (us-east-1a, us-east-1b, us-east-1e) and the "t3.micro" instance type.


### Output-2 (output_v2_2):

~~~~tf
output "output_v2_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
  }
}
~~~~

    Functionality:
        Iterates over each key-value pair in data.aws_ec2_instance_type_offerings.my_ins_type2.
            The key (az) represents the availability zone (e.g., "us-east-1a").
            The value (details) represents the details for that zone.
        Uses a map comprehension to create a new map, where:
            The key is the availability zone (az).
            The value is the list of instance types supported in that zone (details.instance_types).
    Output:
        A map with availability zones as keys and lists of supported instance types as values. Example structure:

        {
          "us-east-1a": ["t3.micro", ...],  // Instance types in us-east-1a
          "us-east-1b": ["t3.micro", ...],  // Instance types in us-east-1b
          "us-east-1e": ["t3.micro", ...]   // Instance types in us-east-1e
        }

Choosing the Right Output Format:
    Use toset if you only care about distinct instance types and don't need to associate them with specific availability zones.
    Use map if you want a structured output that maps availability zones to their supported instance types, allowing you to easily reference instance types based on zones.

Additional Considerations:
    The provided code assumes that the instance-type and location filters will always return results for the specified values. Consider adding error handling or checks to handle potential cases where no results are found.
    If you need to access specific attributes of the instance_types list within the outputs, you can use nested expressions or conditional logic within the Terraform configuration.

By understanding the use of toset and map in Terraform outputs, you can effectively structure the information retrieved from your infrastructure resources for better consumption and utilization.


os valores que são trazidos no key, são devido o for_each no começo do código?
como o terraform entende os valores a inserir na key?
Mostrar rascunhos

Sim, os valores que são trazidos no key do output output_v2_2 são provenientes do for_each no início do código. O Terraform entende os valores a serem inseridos na key da seguinte maneira:

1. Compreendendo o for_each:

O for_each no código itera sobre um conjunto de strings, que neste caso são as zonas de disponibilidade: us-east-1a, us-east-1b e us-east-1e. Para cada zona de disponibilidade, o Terraform:

    Executa a consulta data.aws_ec2_instance_type_offerings.my_ins_type2.
    Filtra os resultados para a oferta de tipo de instância "t3.micro" e a zona de disponibilidade atual.
    Extrai os detalhes da oferta, incluindo os tipos de instância disponíveis.

2. Associando valores à key:

No output output_v2_2, o for_each é usado dentro de uma expressão map para criar um novo mapa. Para cada iteração do for_each:

    A variável az recebe a zona de disponibilidade atual (e.g., "us-east-1a").
    A variável details recebe os detalhes da oferta para a zona de disponibilidade atual.
    A key do mapa é definida como a variável az, que representa a zona de disponibilidade.
    O valor do mapa é definido como a lista de tipos de instância disponíveis na zona de disponibilidade, obtida de details.instance_types.

3. Resultado final:

Ao final da iteração, o output output_v2_2 terá um mapa com as zonas de disponibilidade como chaves e as listas de tipos de instância suportados como valores.

Em resumo:

    O for_each define um conjunto de zonas de disponibilidade que serão utilizadas como base para a iteração.
    Dentro da expressão map, a variável az captura a zona de disponibilidade atual a cada iteração.
    A key do mapa é definida como a variável az, associando cada zona de disponibilidade à sua lista de tipos de instância.

Considerações adicionais:

    O código assume que a oferta "t3.micro" está disponível em todas as zonas de disponibilidade. Se isso não for verdade, você pode precisar adicionar verificações para evitar erros.
    Você pode modificar o código para usar outras variáveis ou funções para definir as chaves e os valores do mapa.

Ao compreender como o Terraform interpreta o for_each e a expressão map neste contexto, você pode construir outputs mais complexos e estruturados para atender às suas necessidades específicas de organização e consulta de dados.





# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Toset remove duplicados.

- Usando um map(definido pelo uso das chaves {}), passamos a ter o key:value.