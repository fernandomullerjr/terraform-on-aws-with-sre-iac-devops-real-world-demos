
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "6. Step-02: Install VSCode Editor, VS Code Terraform Plugin and AWS CLI."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
#  6. Step-02: Install VSCode Editor, VS Code Terraform Plugin and AWS CLI




## PENDENTE
- ver com a XP compra negada com cartão digital temporário, para criar conta AWS  , email fernandomullerjunior-labs@proton.me
- Regularizar nova conta. Ver sobre pagamento pendente na antiga.
- Criar par de chaves AWS.
- Configurar AWS CLI.




## Dia 09/02/2024

- Conta AWS regularizada.


- Criando contas AWS multiaccount
Successfully moved the AWS account 'sandbox-fernando-labs' to the organizational unit 'develop'.
We reprovisioned your AWS accounts successfully and applied the updated permission set to the accounts.


## PENDENTE
- Criar account adicional.
- Criar par de chaves AWS
- Criar alertas de billing
- Criar par de chaves AWS.
- Configurar AWS CLI.



vpc-02261204f793136ff	
Available	172.31.0.0/16

vpc-07f005af7cc2d79b9	
Available	172.31.0.0/16


- Instalar o granted
- Configurar AWS CLI.
- Criar alertas de billing


granted sso populate --sso-region us-east-1 https://d-9067f719d0.awsapps.com/start/


ens33
36
37



- Funcionando via SSO

usando
"#profile = "sandbox-fernando-labs/AdministratorAccess"

~~~~BASH

? Please select the profile you would like to assume: sandbox-fernando-labs/AdministratorAccess
[i] To assume this profile again later without needing to select it, run this command:
> assume sandbox-fernando-labs/AdministratorAccess
[✔] [sandbox-fernando-labs/AdministratorAccess](us-east-1) session credentials will expire in 12 hours
fernando@debian10x64:~$




fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.my_bucket will be created
  + resource "aws_s3_bucket" "my_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "day67taskbucket0304"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.


~~~~






## PENDENTE
- Ver como fazer funcionar o "assume_role" no meu cenário.
- Criar alertas de billing
- Criar par de chaves AWS ou definir outra estratégia???
- Documentar. Granted, TF com role, vm com nat, etc



## Dia 10/02/2024

- Billing, necessário usuário root liberar acesso ao fernandomj90@gmail.com no billing da account, seguir tutorial:?
https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_billing.html?icmpid=docs_iam_console#tutorial-billing-step1


## PENDENTE
- Regularizar acesso a conta AWS via root com email fernandomullerjunior-labs@proton.me




- Regularizar acesso a conta AWS via root com email fernandomullerjunior-labs@proton.me
acesso OK via página de login "normal" ao invés de SSO:
https://console.aws.amazon.com/console/home?region=us-east-1#


IAM user and role access to Billing information  Info
IAM user/role access to billing information
Activated


Bem-vindo ao Gerenciamento de custos da AWS
Como esta é sua primeira visita, levará algum tempo para preparar seus dados de custo e uso. Verifique novamente em 24 horas.

Como parte do seu processo de integração, configuraremos o AWS Cost Anomaly Detection para você. Esse serviço ajuda a monitorar e detectar gastos não intencionais nas suas contas. Para saber mais sobre o serviço ou como cancelá-lo, consulte Conceitos básicos do AWS Cost Anomaly Detection






- Ver como fazer funcionar o "assume_role" no meu cenário.

https://support.hashicorp.com/hc/en-us/articles/360041289933-Using-AWS-AssumeRole-with-the-AWS-Terraform-Provider

~~~~json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "891377134822"
            },
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "7755"
                }
            }
        }
    ]
}
~~~~



Role admin-role-account-sandbox created.

arn:aws:iam::058264180843:role/admin-role-account-sandbox



- Adicionado no main.tf o "aws_caller_identity", para poder obter o account id no outputs:

~~~~tf
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "day67taskbucket0304"
}
~~~~


- Criado outputs.tf para trazer informações do bucket S3 e também do account id:

~~~~tf

output "s3_bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_region" {
  value = aws_s3_bucket.my_bucket.region
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.my_bucket.bucket_domain_name
}

~~~~



- Testando:

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao2-Terraform-Basics/teste-terraform$ terraform plan
data.aws_caller_identity.current: Reading...
data.aws_caller_identity.current: Read complete after 0s [id=058264180843]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.my_bucket will be created
  + resource "aws_s3_bucket" "my_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "day67taskbucket0304"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aws_account_id        = "058264180843"
  + s3_bucket_arn         = (known after apply)
  + s3_bucket_domain_name = (known after apply)
  + s3_bucket_id          = (known after apply)
  + s3_bucket_region      = (known after apply)

~~~~



- Trouxe corretamente o id da conta sandbox
sandbox-fernando-labs

#058264180843



- Testando apply

~~~~bash

aws_s3_bucket.my_bucket: Creating...
aws_s3_bucket.my_bucket: Creation complete after 5s [id=day67taskbucket-sandbox]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

aws_account_id = "058264180843"
s3_bucket_arn = "arn:aws:s3:::day67taskbucket-sandbox"
s3_bucket_domain_name = "day67taskbucket-sandbox.s3.amazonaws.com"
s3_bucket_id = "day67taskbucket-sandbox"
s3_bucket_region = "us-east-1"

~~~~








## PENDENTE
- Criar alertas de billing
- Documentar. Granted, TF com role, vm com nat, etc