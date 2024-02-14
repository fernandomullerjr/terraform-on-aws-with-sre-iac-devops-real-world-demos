
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "18. Step-02: Terraform Settings Block Introduction."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 18. Step-02: Terraform Settings Block Introduction

Step-02: In c1-versions.tf - Create Terraform Settings Block

    Understand about Terraform Settings Block and create it

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


- De forma resumida, no Terraform Block podemos definir:
1. Versão do próprio Terraform que é requerida.
2. Provider que iremos usar e a sua versão.
3. Backend utilizado


- Sobre o ~>
~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
Significa que o Terraform aceita os minor version diferentes, mas não aceita mudanças na casa decimal anterior.

- Cuidar a diferença do uso de chaves "{}" no Terraform Block e outros blocos, o "aws" por exemplo, é um argumento, e as chaves dentro dele são um map, não são um bloco.