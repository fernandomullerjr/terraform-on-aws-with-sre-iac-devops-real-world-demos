
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "48. Step-07: Standardize TF Code - Generic Variables and terraform.tfvars"
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 48. Step-07: Standardize TF Code - Generic Variables and terraform.tfvars

## Step-05: v2-vpc-module-standardized - Standardized and Generalized
- In the next series of steps we are going to standardize the VPC configuration
- c2-generic-variables.tf
```t
# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "HR"
}
```




# ############################################################################
# ############################################################################
# ############################################################################
# 48. Step-07: Standardize TF Code - Generic Variables and terraform.tfvars

- Copiando os manifestos para a pasta "v2-vpc-module-standardized":
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized


## ChatGPT

No Terraform, a precedência das variáveis é determinada por várias fontes, e as variáveis são sobrescritas de acordo com uma ordem específica. Aqui está uma visão geral da precedência das variáveis no Terraform:

    Valores Default: Você pode definir valores padrão para suas variáveis no arquivo de configuração do Terraform.

    Valores da Linha de Comando: Você pode fornecer valores para as variáveis na linha de comando ao executar comandos do Terraform, como terraform apply -var 'key=value'.

    Arquivos de Variáveis: Você pode usar arquivos de variáveis para fornecer valores para suas variáveis. Esses arquivos podem ser de formato .tfvars ou .tfvars.json.

    Variáveis de Ambiente: Você pode definir variáveis de ambiente com o prefixo TF_VAR_. O Terraform reconhecerá essas variáveis e as usará como valores para suas variáveis.

    Variáveis de Output de Outros Módulos: Se você estiver usando módulos, pode usar as saídas (outputs) desses módulos como valores para suas variáveis.

    Valores da Configuração: Você também pode definir valores para variáveis diretamente na configuração do Terraform. Esses valores têm a maior precedência e sobrescreverão qualquer outro valor.

Essa ordem de precedência permite que você defina valores de variáveis em várias fontes e forneça flexibilidade na configuração do seu ambiente de infraestrutura. Certifique-se de entender a ordem de precedência ao trabalhar com variáveis no Terraform para evitar surpresas inesperadas.



## Gemini

A precedência de variáveis no Terraform define a ordem em que o Terraform busca o valor para uma variável específica. Segue a ordem de precedência, da mais alta para a mais baixa:

    Variáveis de ambiente: Valores definidos como variáveis de ambiente do sistema operacional têm a precedência mais alta.
    Arquivo Terraform (*.tfvars): Valores definidos em arquivos separados chamados .tfvars (ou .auto.tfvars) na mesma pasta que o arquivo de configuração do Terraform (.tf) têm a próxima precedência.
    Linha de comando: Valores passados diretamente na linha de comando durante a execução do Terraform têm a precedência seguinte.
    Bloco var no arquivo Terraform: Valores definidos dentro do bloco var no próprio arquivo de configuração do Terraform (.tf) têm a precedência mais baixa.

Em resumo, o Terraform vai buscar o valor de uma variável primeiro nas variáveis de ambiente, depois no arquivo .tfvars, depois na linha de comando e por último no bloco var dentro do arquivo de configuração.