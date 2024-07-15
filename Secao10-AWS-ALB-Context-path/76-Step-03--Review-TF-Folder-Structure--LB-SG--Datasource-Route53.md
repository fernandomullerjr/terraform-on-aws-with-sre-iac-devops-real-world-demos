
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "76. Step-03: Review TF Folder Structure, Update LB SG and Create Datasource Route53."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
# 76. Step-03: Review TF Folder Structure, Update LB SG and Create Datasource Route53

## Step-02: Copy all files from previous section 
- We are going to copy all files from previous section `09-AWS-ALB-Application-LoadBalancer-Basic`
- Files from `c1 to c10`
- Create new files
  - c6-02-datasource-route53-zone.tf
  - c11-acm-certificatemanager.tf
  - c12-route53-dnsregistration.tf
- Review the files
  - app1-install.sh
  - app2-install.sh  

## Step-03: c5-05-securitygroup-loadbalancersg.tf

- Update load balancer security group to allow port 443
```tf
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
```

## Step-04: c6-02-datasource-route53-zone.tf

- Define the datasource for [Route53 Zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)
```tf
# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name = "devopsincloud.com"
}

# Output MyDomain Zone ID
output "mydomain_zoneid" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.zone_id
}
```









# ############################################################################
# ############################################################################
# ############################################################################
# 76. Step-03: Review TF Folder Structure, Update LB SG and Create Datasource Route53


- We are going to copy all files from previous section `09-AWS-ALB-Application-LoadBalancer-Basic`
- Files from `c1 to c10`
- Create new files
  - c6-02-datasource-route53-zone.tf
  - c11-acm-certificatemanager.tf
  - c12-route53-dnsregistration.tf
- Review the files
  - app1-install.sh
  - app2-install.sh  



- Criados os arquivos tf
ajustados para devopsmind.shop

- Ajustando
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao10-AWS-ALB-Context-path/manifestos/c5-05-securitygroup-loadbalancersg.tf
ingress_rules = ["http-80-tcp", "https-443-tcp"]





# ############################################################################
# ############################################################################
# ############################################################################
#  PENDENTE

- Propagação dos NS para o dominio devopsmind.shop da Hostinger propagar com o NS da AWS
criado Hosted zone que nao existia mais, atualizados NS no Hostinger no dia 14/07/204 as 21:45h
<https://dnschecker.org/#NS/devopsmind.shop>
<https://www.whatsmydns.net/#NS/devopsmind.shop>

- Configurar ACM.
ver video <https://www.youtube.com/watch?v=yB3zUwfrsWo> umas idéias e www, etc
s3