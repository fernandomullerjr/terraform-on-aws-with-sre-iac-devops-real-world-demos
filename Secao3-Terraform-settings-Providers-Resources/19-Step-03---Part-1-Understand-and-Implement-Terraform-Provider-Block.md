
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "19. Step-03: Part-1: Understand and Implement Terraform Provider Block."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 19. Step-03: Part-1: Understand and Implement Terraform Provider Block

Step-03: In c1-versions.tf - Create Terraform Providers Block

    Understand about Terraform Providers
    Configure AWS Credentials in the AWS CLI if not configured

# Verify AWS Credentials
cat $HOME/.aws/credentials

    Create AWS Providers Block

# Provider Block
provider "aws" {
  region  = us-east-1
  profile = "default"
}




- O Terraform Provider setado no Terraform Block é baixado do Terraform Registry.



~~~~tf
terraform {
  required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
~~~~


Este nome "aws" é um nome que pode ser personalizado.
Este "Local name" é usado como aws normalmente.


## PENDENTE
- Continua em
08:40h
- Ver sobre versões, que quebra ou não, minor version.


- O "aws" dentro do required_providers é chamado de "Local name".
- Devem ser unicos por módulo.




O nome do source segue a convenção:
    <NOME_DO_AUTOR>/<NOME_DO_PROVEDOR>

Onde:

    <NOME_DO_AUTOR> é o nome do autor ou organização que publicou o provedor.
    <NOME_DO_PROVEDOR> é o nome do provedor.

No exemplo acima, hashicorp é o nome do autor e aws é o nome do provedor. Portanto, hashicorp/aws é o caminho completo para o provedor AWS fornecido pela HashiCorp.










O source de um required_providers no Terraform é um bloco de configuração que especifica os provedores que um módulo Terraform precisa para funcionar. Este bloco é essencial para garantir que o módulo possa ser usado com sucesso em diferentes ambientes, pois define as dependências de provedores do módulo.

Estrutura do source:

O bloco required_providers é composto por duas propriedades principais:

    provider: O nome do provedor que o módulo requer.

    source: A origem do provedor, que pode ser:
        hashicorp/aws: Indica que o provedor é gerenciado pela HashiCorp e está disponível no registro oficial do Terraform.
        registry.terraform.io/hashicorp/aws: Similar ao anterior, mas especifica o registro Terraform como a fonte.
        git::https://github.com/hashicorp/terraform-provider-aws.git?ref=v3.79.0: Indica que o provedor é obtido de um repositório Git específico.
        ./path/to/provider: Indica que o provedor está instalado localmente no diretório especificado.

Composição do nome do source:

O nome do source é composto por vários elementos, dependendo da origem do provedor:

    Provedores gerenciados pela HashiCorp:
        Nome do provedor (ex: aws)

    Provedores do registro Terraform:
        "registry.terraform.io/"
        Nome do provedor (ex: hashicorp/aws)

    Provedores de repositórios Git:
        "git::"
        URL do repositório Git
        (opcional) "?ref=" + versão do provedor

    Provedores locais:
        Caminho relativo ou absoluto para o diretório do provedor

Exemplos:

~~~~tf

required_providers {
  aws = "~> 3.78"
}

required_providers {
  aws = {
    source = "registry.terraform.io/hashicorp/aws"
  }
}

required_providers {
  aws = {
    source = "git::https://github.com/hashicorp/terraform-provider-aws.git?ref=v3.79.0"
  }
}

required_providers {
  aws = "./terraform-provider-aws"
}
~~~~


Use o código com cuidado.

Observações importantes:

    É recomendável especificar a versão mínima do provedor necessária para garantir a compatibilidade com o módulo.
    Ao usar provedores de repositórios Git, é importante verificar se a versão especificada é compatível com o módulo.
    Ao usar provedores locais, certifique-se de que o provedor esteja instalado e disponível no sistema antes de executar o Terraform.
