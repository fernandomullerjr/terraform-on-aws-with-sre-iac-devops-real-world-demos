
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



## Source Addresses

https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses
<https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses>

A provider's source address is its global identifier. It also specifies the primary location where Terraform can download it.

Source addresses consist of three parts delimited by slashes (/), as follows:

[<HOSTNAME>/]<NAMESPACE>/<TYPE>

Examples of valid provider source address formats include:

    NAMESPACE/TYPE
    HOSTNAME/NAMESPACE/TYPE

    Hostname (optional): The hostname of the Terraform registry that distributes the provider. If omitted, this defaults to registry.terraform.io, the hostname of the public Terraform Registry.

    Namespace: An organizational namespace within the specified registry. For the public Terraform Registry and for Terraform Cloud's private registry, this represents the organization that publishes the provider. This field may have other meanings for other registry hosts.

    Type: A short name for the platform or system the provider manages. Must be unique within a particular namespace on a particular registry host.

    The type is usually the provider's preferred local name. (There are exceptions; for example, hashicorp/google-beta is an alternate release channel for hashicorp/google, so its preferred local name is google. If in doubt, check the provider's documentation.)

For example, the official HTTP provider belongs to the hashicorp namespace on registry.terraform.io, so its source address is registry.terraform.io/hashicorp/http or, more commonly, just hashicorp/http.

The source address with all three components given explicitly is called the provider's fully-qualified address. You will see fully-qualified address in various outputs, like error messages, but in most cases a simplified display version is used. This display version omits the source host when it is the public registry, so you may see the shortened version "hashicorp/random" instead of "registry.terraform.io/hashicorp/random".



O nome do source segue a convenção:
    <NOME_DO_AUTOR>/<NOME_DO_PROVEDOR>

Onde:

    <NOME_DO_AUTOR> é o nome do autor ou organização que publicou o provedor.
    <NOME_DO_PROVEDOR> é o nome do provedor.

No exemplo acima, hashicorp é o nome do autor e aws é o nome do provedor. Portanto, hashicorp/aws é o caminho completo para o provedor AWS fornecido pela HashiCorp.








## EXTRA

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









