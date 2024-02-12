
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "13. Step-09: Terraform Configuration Syntax."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 13. Step-09: Terraform Configuration Syntax

<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/02-Terraform-Basics/02-03-Terraform-Language-Syntax>


# Terraform Configuration Language Syntax

## Step-01: Introduction
- Understand Terraform Language Basics
  - Understand Blocks
  - Understand Arguments, Attributes & Meta-Arguments
  - Understand Identifiers
  - Understand Comments
 


## Step-02: Terraform Configuration Language Syntax
- Understand Blocks
- Understand Arguments
- Understand Identifiers
- Understand Comments
- [Terraform Configuration](https://www.terraform.io/docs/configuration/index.html)
- [Terraform Configuration Syntax](https://www.terraform.io/docs/configuration/syntax.html)
```t
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS Example
resource "aws_instance" "ec2demo" { # BLOCK
  ami           = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf
}
```

## Step-03: Understand about Arguments, Attributes and Meta-Arguments.
- Arguments can be `required` or `optional`
- Attribues format looks like `resource_type.resource_name.attribute_name`
- Meta-Arguments change a resource type's behavior (Example: count, for_each)
- [Additional Reference](https://learn.hashicorp.com/tutorials/terraform/resource?in=terraform/configuration-language) 
- [Resource: AWS Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: AWS Instance Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)
- [Resource: AWS Instance Attribute Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference)
- [Resource: Meta-Arguments](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

## Step-04: Understand about Terraform Top-Level Blocks
- Discuss about Terraform Top-Level blocks
  - Terraform Settings Block
  - Provider Block
  - Resource Block
  - Input Variables Block
  - Output Values Block
  - Local Values Block
  - Data Sources Block
  - Modules Block





# ############################################################################
# ############################################################################
# ############################################################################
# 13. Step-09: Terraform Configuration Syntax

exemplos de comentários usando duas barras (//), o caractere # e comentários de várias linhas:

## Comentários de Duas Barras (//)

~~~~tf

// Este é um comentário de uma linha usando duas barras
variable "subnet_id" {
  // Este é um comentário de uma linha dentro de um bloco de recurso
  description = "ID da sub-rede na qual lançar a instância"
}
~~~~


## Comentários com #

~~~~tf

# Este é um comentário de uma linha usando o caractere #
resource "aws_instance" "example" {
  # Aqui está uma configuração específica
  ami           = "ami-12345678"
  instance_type = "t2.micro"  # Tipo de instância micro
}
~~~~


## Comentários de Múltiplas Linhas

~~~~tf
/*
  Este é um comentário de várias linhas usando barras e asteriscos.
  Ele pode ser usado para explicar partes mais complexas do código.
*/
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
~~~~

Esses exemplos demonstram diferentes formas de adicionar comentários em um arquivo Terraform usando duas barras (//), o caractere # e comentários de várias linhas. Escolha o estilo de comentário que melhor se adequa ao seu código e à sua preferência pessoal.