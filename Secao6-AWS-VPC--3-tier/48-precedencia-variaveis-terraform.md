



- Precedencia das variáveis no Terraform:

https://www.terraform.io/language/values/variables
Variable Definition Precedence

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

    Environment variables
    The terraform.tfvars file, if present.
    The terraform.tfvars.json file, if present.
    Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
    Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)




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




## Explicação adicional sobre precedencia de variáveis no Terraform

No Terraform, é possível utilizar diversos métodos de configuração de variáveis em qualquer combinação. Isso sempre me confunde, então mantive aqui para consultá-lo em vez de consultar a documentação do Terraform.

O Terraform usará o último valor encontrado e substituirá quaisquer valores anteriores se uma variável receber vários valores. Lembre-se de que uma variável não pode receber vários valores dentro de uma fonte.

O Terraform carrega variáveis na seguinte ordem: as fontes posteriores têm precedência.

     Variáveis ​​ambientais
     O arquivo terraform.tfvars, se presente.
     O arquivo terraform.tfvars.json, se presente.
     Quaisquer arquivos *.auto.tfvars ou *.auto.tfvars.json, processados em ordem lexical de seus nomes de arquivo.
     Quaisquer opções -var e -var-file na linha de comando, na ordem em que são fornecidas. (Isso inclui variáveis definidas por um espaço de trabalho do Terraform Cloud.)





<https://dataisadope.com/blog/terraform-variable-definition-precedence/>
Terraform loads variables in the following order: later sources take precedence.

    Environment variables
    The terraform.tfvars file, if present.
    The terraform.tfvars.json file, if present.
    Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
    Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)



## Melhor explicação
- Melhor explicação sobre precedencia:
<https://www.oreilly.com/library/view/hashicorp-certified-terraform/9780138195366/HCT1_01_07_07.html>



- As variáveis informadas no arquivo *terraform.tfvars* sobrepõem os valores das variáveis existentes no arquivo *c2-generic-variables.tf*

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized/terraform.tfvars
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao6-AWS-VPC--3-tier/v2-vpc-module-standardized/c2-generic-variables.tf





# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- A precedencia de variáveis no Terraform é assim(ordenei para que as primeiras sejam as mais importantes, em outros materiais está ao contrário):

## -var and -var-file options on the command line
    Any -var and -var-file options on the command line, in the order they are provided(with `terraform apply`). (This includes variables set by a Terraform Cloud workspace.) 

## *.auto.tfvars or *.auto.tfvars.json files
    Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.

## terraform.tfvars.json file
    The terraform.tfvars.json file, if present.

## terraform.tfvars
    The terraform.tfvars file, if present.

## Environment variables
    Environment variables, TF_VAR=