
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "49. Step-08: Understand and Implement Local Blocks"
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 49. Step-08: Understand and Implement Local Blocks

## Step-06: c3-local-values.tf
- Understand about [Local Values](https://www.terraform.io/docs/language/values/locals.html)

```tf
# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment     
  }
}
```





# ############################################################################
# ############################################################################
# ############################################################################
# 49. Step-08: Understand and Implement Local Blocks

[Local Values](https://www.terraform.io/docs/language/values/locals.html)


No Terraform, as "locals" são blocos usados para definir valores intermediários ou calculados dentro de um arquivo de configuração. Eles permitem atribuir valores a variáveis que são usadas várias vezes em diferentes partes do seu código Terraform. Isso pode tornar seu código mais legível, mais fácil de manter e menos propenso a erros.

Aqui está um exemplo simples de como os locals podem ser usados:

~~~~tf
locals {
  region = "us-west-2"
  ami_id = "ami-12345678"
}

resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  region        = local.region
}
~~~~

Neste exemplo, local.region e local.ami_id são definidos uma vez no bloco locals e podem ser usados em todo o arquivo de configuração. Se você precisar alterar o AMI ou a região, só precisará fazer isso em um lugar.

As vantagens de usar locals incluem:

    Reutilização de valores: Você pode definir valores que são usados em vários lugares em seu código, evitando repetição e mantendo a consistência.

    Legibilidade: Ao atribuir nomes descritivos aos seus locals, você pode tornar seu código mais legível e compreensível para outras pessoas que possam estar lendo ou mantendo-o.

    Facilidade de manutenção: Se você precisar fazer alterações em valores usados em várias partes do seu código, só precisa atualizá-los em um local.

    Escopo local: Os locals são escopos apenas dentro do arquivo Terraform em que são definidos, o que os torna úteis para criar variáveis locais que não precisam ser expostas fora do arquivo.

Em resumo, os locals são uma ferramenta útil para melhorar a organização, legibilidade e manutenção do seu código Terraform.







## Locals no Terraform: Entendendo Funções e Vantagens

O que são Locals?

As "locals" no Terraform são variáveis temporárias e de escopo local dentro de um módulo ou bloco de código. Elas permitem definir valores dinâmicos e reutilizáveis dentro do mesmo contexto, sem a necessidade de declarar variáveis no nível superior do módulo.

Funcionamento:

    As locals são definidas dentro de um bloco locals usando a palavra-chave local.
    O valor da local pode ser uma expressão complexa, incluindo outras locals, variáveis, funções e recursos do Terraform.
    As locals são reavaliadas a cada execução do Terraform, garantindo que seus valores estejam sempre atualizados.

Exemplos de uso:

    Calcular valores dinâmicos: por exemplo, a soma de duas variáveis.
    Armazenar valores intermediários para evitar cálculos repetitivos.
    Criar blocos de código condicional com base em valores dinâmicos.

Vantagens:

    Reutilização: facilitam a reutilização de código em diferentes módulos.
    Modularidade: promovem a organização e a modularização do código.
    Legibilidade: tornam o código mais legível e fácil de entender.
    Manutenabilidade: facilitam a manutenção e o gerenciamento do código.

Limitações:

    As locals não são persistentes entre diferentes execuções do Terraform.
    O escopo das locals é limitado ao módulo ou bloco de código em que são definidas.

Em resumo:

As locals são uma ferramenta poderosa para tornar o código Terraform mais modular, reutilizável, legível e fácil de manter. Elas permitem definir valores dinâmicos e reutilizáveis dentro de um módulo ou bloco de código, com diversas vantagens para o desenvolvimento e gerenciamento de infraestrutura.

Recursos adicionais:

    Documentação oficial do Terraform sobre locals: https://developer.hashicorp.com/terraform/language/values/locals
    Tutoriais sobre locals:
        https://developer.hashicorp.com/terraform/language/values/locals
        https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean

Exemplo prático:

~~~~tf
locals {
  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.public.id,
    aws_subnet.private.id,
  ]
}
~~~~


~~~~tf
resource "aws_instance" "web" {
  count = 2

  vpc_id = local.vpc_id
  subnet_id = local.subnet_ids[count.index]

  ...
}
~~~~

Neste exemplo, a local vpc_id armazena o ID da VPC principal e a local subnet_ids armazena uma lista de IDs das sub-redes. As locals são então usadas para definir os valores das propriedades vpc_id e subnet_id da instância aws_instance.








# Relação entre Locals e Expressões no Terraform

As locals e as expressões no Terraform estão intimamente relacionadas, pois ambas permitem definir valores dinâmicos dentro do código. No entanto, existem diferenças importantes em termos de funcionalidade e escopo.

Expressões:

    As expressões são usadas para calcular valores dinâmicos a partir de variáveis, funções e outros elementos do Terraform.
    O escopo das expressões é limitado à linha ou bloco de código em que são usadas.
    As expressões podem ser usadas em qualquer lugar do código Terraform, incluindo dentro de recursos, módulos e locals.

Locals:

    As locals são variáveis temporárias e de escopo local dentro de um módulo ou bloco de código.
    As locals podem ser usadas para armazenar valores intermediários ou resultados de cálculos complexos.
    O escopo das locals é limitado ao módulo ou bloco de código em que são definidas.

Relação:

    As locals podem ser utilizadas dentro de expressões para calcular valores dinâmicos.
    As expressões podem ser utilizadas para definir valores para as locals.

Exemplos:

1. Usando uma local dentro de uma expressão:

~~~~tf
locals {
  vpc_id = aws_vpc.main.id
}

resource "aws_instance" "web" {
  count = 2

  vpc_id = local.vpc_id

  ...
}
~~~~

Use o código com cuidado.

Neste exemplo, a local vpc_id armazena o ID da VPC principal. A local é então utilizada dentro da expressão para definir o valor da propriedade vpc_id da instância aws_instance.

2. Usando uma expressão para definir uma local:

~~~~tf
locals {
  subnet_ids = [
    for subnet in aws_subnets.public : subnet.id
  ]
}

resource "aws_instance" "web" {
  count = 2

  subnet_id = local.subnet_ids[count.index]

}
~~~~

Use o código com cuidado.

Neste exemplo, a local subnet_ids é definida usando uma expressão que itera sobre as sub-redes públicas e armazena seus IDs em uma lista. A local é então utilizada para definir o valor da propriedade subnet_id da instância aws_instance.

Em resumo:

As locals e as expressões são ferramentas complementares que podem ser usadas para definir valores dinâmicos no Terraform. As locals são mais adequadas para armazenar valores intermediários ou resultados de cálculos complexos, enquanto as expressões são mais adequadas para realizar cálculos dinâmicos simples. A combinação de locals e expressões permite criar código Terraform mais modular, reutilizável e legível.






# Variáveis vs. Locals no Terraform: Trabalhando com Expressões

Sim, as variáveis do Terraform também podem trabalhar com expressões, assim como as locals. No entanto, existem diferenças importantes na forma como elas funcionam:

Expressões com Variáveis:

    As variáveis podem ser usadas em expressões para calcular valores dinâmicos.
    O escopo das variáveis é global, ou seja, elas podem ser acessadas em qualquer lugar do código Terraform.
    As variáveis não são reavaliadas a cada execução do Terraform. O valor da variável é definido no momento em que o módulo é carregado e não é atualizado durante a execução.

Expressões com Locals:

    As locals também podem ser usadas em expressões para calcular valores dinâmicos.
    O escopo das locals é local, ou seja, elas só podem ser acessadas dentro do módulo ou bloco de código em que foram definidas.
    As locals são reavaliadas a cada execução do Terraform, garantindo que seus valores estejam sempre atualizados.

Em resumo:

    As variáveis são mais adequadas para valores estáticos que não precisam ser atualizados com frequência.
    As locals são mais adequadas para valores dinâmicos que precisam ser reavaliados a cada execução do Terraform.








# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- O valor da local pode ser uma expressão complexa, incluindo outras locals, variáveis, funções e recursos do Terraform.

- As locals e as expressões são ferramentas complementares que podem ser usadas para definir valores dinâmicos no Terraform. As locals são mais adequadas para armazenar valores intermediários ou resultados de cálculos complexos, enquanto as expressões são mais adequadas para realizar cálculos dinâmicos simples. A combinação de locals e expressões permite criar código Terraform mais modular, reutilizável e legível.

- As variáveis são mais adequadas para valores estáticos que não precisam ser atualizados com frequência.

- As locals são mais adequadas para valores dinâmicos que precisam ser reavaliados a cada execução do Terraform.
