
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "20. Step-04: Part-2: Implement Provider Block."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 20. Step-04: Part-2: Implement Provider Block


## Authentication and Configuration
<https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication>

Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:

    Parameters in the provider configuration
    Environment variables
    Shared credentials files
    Shared configuration files
    Container credentials
    Instance profile credentials and Region


- Autenticando via chaves AWS
Credentials can be provided by adding an access_key, secret_key, and optionally token, to the aws provider block.

Usage:

~~~~TF
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
~~~~