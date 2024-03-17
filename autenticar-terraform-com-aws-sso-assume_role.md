 

# ##################################################################################################################################################
# ##################################################################################################################################################
# ##################################################################################################################################################
# Efetuar autenticação do Terraform na AWS com SSO, usando assume_role

- Material de apoio
<https://hector-reyesaleman.medium.com/terraform-aws-provider-everything-you-need-to-know-about-multi-account-authentication-and-f2343a4afd4b>
<https://support.hashicorp.com/hc/en-us/articles/360041289933-Using-AWS-AssumeRole-with-the-AWS-Terraform-Provider>


- No provider, foi passado um profile que será usado como base, como se fosse conta-A:

~~~~tf
provider "aws" {
  # Região onde seus recursos serão provisionados
  region = "us-east-1"

  profile = "fernandomullerjunior-labs/AdministratorAccess"

    assume_role {
    role_arn     = "arn:aws:iam::058264180843:role/admin-role-account-sandbox"
    # (Optional) The external ID created in step 1c.
    external_id = "7755"
    session_name = "terraform-session"
  }
}

~~~~

na conta-B é necessária a role, permitindo o account id da conta-A e usando o external id citado.
neste cenário foi usado o profile fixo "fernandomullerjunior-labs/AdministratorAccess", porque ele dificilmente vai variar.
Numa empresa pode ser interessante outra abordagem, estilo "Shared-Services Account", como pode ser visto:
<https://hector-reyesaleman.medium.com/terraform-aws-provider-everything-you-need-to-know-about-multi-account-authentication-and-f2343a4afd4b>


- Exemplo de como está o aws config, usando granted:

~~~~bash

fernando@debian10x64:~$ cat ~/.aws/config
[default]
region = us-east-1
output = json

[profile fernandomuller]
region = us-east-1
output = json

[profile fernandomullerjunior-labs/AdministratorAccess]
granted_sso_start_url      = https://d-9067f719d0.awsapps.com/start/
granted_sso_region         = us-east-1
granted_sso_account_id     = 891377134822
granted_sso_role_name      = AdministratorAccess
common_fate_generated_from = aws-sso
credential_process         = granted credential-process --profile fernandomullerjunior-labs/AdministratorAccess

[profile sandbox-fernando-labs/AdministratorAccess]
granted_sso_start_url      = https://d-9067f719d0.awsapps.com/start/
granted_sso_region         = us-east-1
granted_sso_account_id     = 058264180843
granted_sso_role_name      = AdministratorAccess
common_fate_generated_from = aws-sso
credential_process         = granted credential-process --profile sandbox-fernando-labs/AdministratorAccess
fernando@debian10x64:~$ vi /tmp/teste.txt
You have new mail in /var/mail/fernando
fernando@debian10x64:~$




~~~~



- Demais arquivos tf só serviram para os testes, não são mandatórios nas configurações do SSO:

main.tf

~~~~tf
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "day67taskbucket0304"
}
~~~~

outputs.tf

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