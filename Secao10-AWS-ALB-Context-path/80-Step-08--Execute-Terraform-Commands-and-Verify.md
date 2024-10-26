
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "80. Step-08: Execute Terraform Commands and Verify ."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#   80. Step-08: Execute Terraform Commands and Verify

## Step-11: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify
Observation: 
1. Verify EC2 Instances for App1
2. Verify EC2 Instances for App2
3. Verify Load Balancer SG - Primarily SSL 443 Rule
4. Verify ALB Listener - HTTP:80 - Should contain a redirect from HTTP to HTTPS
5. Verify ALB Listener - HTTPS:443 - Should contain 3 rules 
5.1 /app1* to app1-tg 
5.2 /app2* to app2-tg 
5.3 /* return Fixed response
6. Verify ALB Target Groups App1 and App2, Targets (should be healthy) 
5. Verify SSL Certificate (Certificate Manager)
6. Verify Route53 DNS Record

# Test (Domain will be different for you based on your registered domain)
# Note: All the below URLS shoud redirect from HTTP to HTTPS
1. Fixed Response: http://apps.devopsincloud.com   
2. App1 Landing Page: http://apps.devopsincloud.com/app1/index.html
3. App1 Metadata Page: http://apps.devopsincloud.com/app1/metadata.html
4. App2 Landing Page: http://apps.devopsincloud.com/app2/index.html
5. App2 Metadata Page: http://apps.devopsincloud.com/app2/metadata.html
```

## Step-12: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```


## References
- [Terraform AWS ALB](https://github.com/terraform-aws-modules/terraform-aws-alb)




# ############################################################################
# ############################################################################
# ############################################################################
#   80. Step-08: Execute Terraform Commands and Verify

15:49h

Plan: 60 to add, 0 to change, 0 to destroy.



module.acm.aws_acm_certificate_validation.this[0]: Still creating... [6m22s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [6m31s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [6m40s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [6m50s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [6m59s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m8s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m17s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m26s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m35s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m44s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [7m53s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [8m2s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [8m11s elapsed]




_a3076ba9441245e5468b27d92da835f6.devopsmind.shop


dig -t CNAME <valor_do_CNAME_gerado_pela_AWS>
dig -t CNAME _a3076ba9441245e5468b27d92da835f6.devopsmind.shop



> dig -t CNAME _a3076ba9441245e5468b27d92da835f6.devopsmind.shop

; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> -t CNAME _a3076ba9441245e5468b27d92da835f6.devopsmind.shop
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39948
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;_a3076ba9441245e5468b27d92da835f6.devopsmind.shop. IN CNAME

;; AUTHORITY SECTION:
devopsmind.shop.        900     IN      SOA     ns-1785.awsdns-31.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400

;; Query time: 33 msec
;; SERVER: 8.8.8.8#53(8.8.8.8) (UDP)
;; WHEN: Sat Oct 26 15:57:03 -03 2024
;; MSG SIZE  rcvd: 165

> date
Sat Oct 26 15:57:09 -03 2024






- Name Servers atuais no Route53

Name servers
ns-1686.awsdns-18.co.uk
ns-1434.awsdns-51.org
ns-548.awsdns-04.net
ns-259.awsdns-32.com



- Propagadas no NS  para o devopsmind.shop:

ns-630.awsdns-14.net.
ns-1327.awsdns-37.org.
ns-383.awsdns-47.com.
ns-1785.awsdns-31.co.uk. 	




- Ajuste na Hostinger:

26/10/2024 as 16:01h

Servidores de DNS alterados!

Seus servidores de DNS foram alterados para:

ns-1434.awsdns-51.org

ns-1686.awsdns-18.co.uk

ns-259.awsdns-32.com

ns-548.awsdns-04.net
Pode levar até 24 horas para o domínio se propagar com os novos servidores de DNS.





- Efetuando Destroy enquanto isto:

module.vpc.aws_route_table.database[0]: Destruction complete after 1s
module.vpc.aws_route_table.public[0]: Destruction complete after 2s
module.vpc.aws_route_table.private[0]: Destruction complete after 1s
module.vpc.aws_nat_gateway.this[0]: Still destroying... [id=nat-04dc9475017a5c959, 9s elapsed]
module.vpc.aws_nat_gateway.this[0]: Still destroying... [id=nat-04dc9475017a5c959, 18s elapsed]
module.vpc.aws_nat_gateway.this[0]: Still destroying... [id=nat-04dc9475017a5c959, 27s elapsed]
module.vpc.aws_nat_gateway.this[0]: Still destroying... [id=nat-04dc9475017a5c959, 36s elapsed]
module.vpc.aws_nat_gateway.this[0]: Destruction complete after 37s
module.vpc.aws_subnet.public[1]: Destroying... [id=subnet-0dfa5fc1ba431e32d]
module.vpc.aws_eip.nat[0]: Destroying... [id=eipalloc-004cd15055f94b4be]
module.vpc.aws_subnet.public[0]: Destroying... [id=subnet-0dbc24db2f30275b8]
module.vpc.aws_subnet.public[0]: Destruction complete after 1s
module.vpc.aws_subnet.public[1]: Destruction complete after 1s
module.vpc.aws_eip.nat[0]: Destruction complete after 2s
module.vpc.aws_internet_gateway.this[0]: Destroying... [id=igw-0c33d7f73889a423e]
module.vpc.aws_internet_gateway.this[0]: Destruction complete after 1s
module.vpc.aws_vpc.this[0]: Destroying... [id=vpc-05e44a69ecfa58bed]
module.vpc.aws_vpc.this[0]: Destruction complete after 1s

Destroy complete! Resources: 55 destroyed.





# ############################################################################
# ############################################################################
# ############################################################################
# PENDENTE

- Validar que o ajuste dos NS surtiu efeito, para poder validar o certificado ACM:
https://dnschecker.org/#NS/devopsmind.shop
<https://dnschecker.org/#NS/devopsmind.shop>

- Retomar apply e testes.