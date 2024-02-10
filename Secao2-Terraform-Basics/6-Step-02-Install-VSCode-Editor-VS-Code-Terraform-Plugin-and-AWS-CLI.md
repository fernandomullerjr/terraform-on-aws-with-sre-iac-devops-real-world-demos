
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
- Documentar.