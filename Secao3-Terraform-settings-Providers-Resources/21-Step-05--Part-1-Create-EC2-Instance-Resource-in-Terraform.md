
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "21. Step-05: Part-1: Create EC2 Instance Resource in Terraform."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 21. Step-05: Part-1: Create EC2 Instance Resource in Terraform

Step-04: In c2-ec2instance.tf - Create Resource Block

    Understand about Resources
    Create EC2 Instance Resource
    Understand about File Function
    Understand about Resources - Argument Reference
    Understand about Resources - Attribute Reference

~~~~tf
# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
~~~~



## Resource Syntax

<https://developer.hashicorp.com/terraform/language/resources/syntax>

A resource block declares a resource of a specific type with a specific local name. Terraform uses the name when referring to the resource in the same module, but it has no meaning outside that module's scope.

In the following example, the aws_instance resource type is named web. The resource type and name must be unique within a module because they serve as an identifier for a given resource.

~~~~tf
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}

~~~~




## Meta-Arguments
The Meta-Arguments section documents special arguments that can be used with every resource type, including depends_on, count, for_each, provider, and lifecycle.

Os "Meta-Arguments" no Terraform são argumentos especiais que podem ser aplicados a todos os recursos em um bloco. Eles não são específicos de um recurso individual, mas sim aplicáveis globalmente a todos os recursos dentro de um bloco, como um bloco de recurso ou um módulo.

Aqui estão alguns dos Meta-Arguments mais comuns:

    count: Este Meta-Argument permite criar múltiplas instâncias de um recurso com base em um valor numérico. Por exemplo, você pode usar count para criar várias instâncias EC2 com base em um número especificado.

    Exemplo:

~~~~tf
resource "aws_instance" "example" {
  count = 3
  instance_type = "t2.micro"
  ami = "ami-0c55b159cbfafe1f0"
}
~~~~

for_each: Similar ao count, mas permite criar instâncias de recursos com base em uma coleção de valores, como um mapa ou um conjunto. Isso oferece mais flexibilidade do que count, pois você pode especificar instâncias de recursos com base em chaves únicas.

Exemplo:

~~~~tf
locals {
  instance_config = {
    web = { instance_type = "t2.micro", ami = "ami-0c55b159cbfafe1f0" }
    db  = { instance_type = "t2.small", ami = "ami-12345678" }
  }
}

resource "aws_instance" "example" {
  for_each = local.instance_config
  instance_type = each.value.instance_type
  ami = each.value.ami
  tags = {
    Name = each.key
  }
}
~~~~


provider: Este Meta-Argument permite especificar um provedor específico para um recurso dentro de um bloco. Isso é útil quando você precisa usar provedores diferentes para recursos dentro do mesmo bloco.

Exemplo:

~~~~tf
    resource "aws_instance" "example" {
      provider = aws.us-west-1
      instance_type = "t2.micro"
      ami = "ami-0c55b159cbfafe1f0"
    }
~~~~

Boas práticas ao usar Meta-Arguments:

    Use count e for_each com cuidado, pois eles podem resultar em muitas instâncias de recursos e potencialmente aumentar os custos e a complexidade de gerenciamento.
    Ao usar for_each, verifique se a coleção de valores é única para evitar conflitos.
    Ao usar provider, documente claramente por que um provedor específico está sendo usado para um recurso, especialmente se for diferente do provedor padrão configurado no nível do ambiente.
    Teste suas configurações com Meta-Arguments para garantir que elas estejam criando os recursos conforme o esperado e que não haja impactos indesejados.



# ############################################################################
# ############################################################################
# ############################################################################
# EXTRA

## GPT

## Argumentos
Argumentos: São valores que são passados para os recursos ou módulos no Terraform. Eles definem as características específicas do recurso ou módulo. Por exemplo, ao criar uma instância EC2 na AWS, os argumentos podem incluir o tipo de instância, a imagem AMI a ser usada, as configurações de rede, etc.

Exemplo:

~~~~tf
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-0c55b159cbfafe1f0"
  subnet_id     = "subnet-12345678"
}
~~~~


## Atributos
Atributos: São valores que são retornados pelo Terraform após a criação ou manipulação de recursos. Esses valores podem ser usados em outras partes da configuração Terraform. Por exemplo, o ID de uma instância EC2 criada pode ser um atributo que você deseja usar em outro recurso.

Exemplo:

~~~~tf
output "instance_id" {
  value = aws_instance.example.id
}
~~~~


## Blocos
Blocos: São estruturas de configuração que agrupam um conjunto de configurações relacionadas. Os blocos têm uma palavra-chave seguida de chaves {} que contêm as configurações relacionadas. Por exemplo, um bloco de recurso é usado para definir um recurso específico, como uma instância EC2 ou um bucket S3.

Exemplo:

~~~~tf
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-0c55b159cbfafe1f0"
  subnet_id     = "subnet-12345678"
}
~~~~


# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- O "name" do recurso deve ser único.
- Ele pode ser referenciado apenas dentro do módulo root.