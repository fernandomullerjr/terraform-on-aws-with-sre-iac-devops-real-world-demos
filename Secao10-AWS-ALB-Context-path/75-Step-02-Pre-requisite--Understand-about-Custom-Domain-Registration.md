
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "75. Step-02: Pre-requisite: Understand about Custom Domain Registration."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#   75. Step-02: Pre-requisite: Understand about Custom Domain Registration



## Step-00: Pre-requisites
- You need a Registered Domain in AWS Route53 to implement this usecase
- Lets discuss more about it
- Go to AWS Services -> Route53 -> Domains -> Registered Domains -> Register Domain
- Choose a domain name: abcabc.com and click on **Check** 


## PENDENTE
- Configurar o dominio que eu comprei
devopsmind.shop

<https://us-east-1.console.aws.amazon.com/route53/v2/home?region=us-east-1#Dashboard>

Registro de devopsmind.shop finalizado

Confirme as informações do domínio

Essas informações serão usadas para registrar o domínio. Informações incorretas podem causar a suspensão do domínio.



Visão Geral do Domínio
- Domínios - devopsmind.shop
devopsmind.shop
Ativo

fernandomj90@gmail.com
Expira em: 2025-07-07



- Route53
devopsmind.shop was successfully created.
Now you can create records in the hosted zone to specify how you want Route 53 to route traffic for your domain.


Servidores de DNS alterados!

Seus servidores de DNS foram alterados para:

ns-1686.awsdns-18.co.uk

ns-1434.awsdns-51.org

ns-548.awsdns-04.net

ns-259.awsdns-32.com
Pode levar até 24 horas para o domínio se propagar com os novos servidores de DNS.



- Criando CNAME apontando para o .com.br
Record for devopsmind.shop was successfully created.
Route 53 propagates your changes to all of the Route 53 authoritative DNS servers within 60 seconds. Use "View status" button to check propagation status.

Route 53
Hosted zones
devopsmind.shop

    Change Info

C05966081IHWMB4IIJ4VV  Info
Change info details
ID
/change/C05966081IHWMB4IIJ4VV
Status
PENDING
Submitted at
July 06, 2024, 23:46 (UTC:-03:00)
Comment


23:47h
Status
INSYNC




# ############################################################################
# ############################################################################
# ############################################################################
# PENDENTE

- Dominio devopsmind.shop ainda não propagou(23:51h - 06/07/2024)
verificar propagação, <https://www.whatsmydns.net/#NS/devopsmind.shop>
testar os CNAME's



## Dia 14/07/2024

Dominio devopsmind.shop
verificando tava propagado, mas NS obsoletos
criado Hosted zone que nao existia mais, atualizados NS no Hostinger


- ACM
Successfully requested certificate with ID 5046aed4-5d75-4800-96cb-e064138bcf41
A certificate request with a status of pending validation has been created. Further action is needed to complete the validation and approval of the certificate.

- DNS
Record for devopsmind.shop was successfully created.
Route 53 propagates your changes to all of the Route 53 authoritative DNS servers within 60 seconds. Use "View status" button to check propagation status.

C04489253MYOYXMLQRQ8F  Info
Change info details
ID
/change/C04489253MYOYXMLQRQ8F
Status
INSYNC
Submitted at
July 14, 2024, 21:39 (UTC:-03:00)
Comment




## PENDENTE
- Propagação dos NS
criado Hosted zone que nao existia mais, atualizados NS no Hostinger no dia 14/07/204 as 21:45h

- Configurar ACM.
ver video <https://www.youtube.com/watch?v=yB3zUwfrsWo> umas idéias e www, etc
s3


