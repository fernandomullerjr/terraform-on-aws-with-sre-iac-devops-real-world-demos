
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




- Atualizando
16:18h
propagou parcial




- Novo apply

Mesmo com a propagação parcial
ACM ficou "issued"

~~~~bash

module.acm.aws_acm_certificate_validation.this[0]: Still creating... [3m38s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [3m47s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [3m56s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [4m5s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [4m15s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Still creating... [4m24s elapsed]
module.acm.aws_acm_certificate_validation.this[0]: Creation complete after 4m25s [id=0001-01-01 00:00:00 +0000 UTC]
module.alb.aws_lb_listener.this["my-https-listener"]: Creating...
module.alb.aws_lb_listener.this["my-http-https-redirect"]: Creating...
module.alb.aws_lb_listener.this["my-https-listener"]: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:058264180843:listener/app/SAP-dev-alb/09e97bf69c4b5028/d87a18f41d72b35c]
module.alb.aws_lb_listener.this["my-http-https-redirect"]: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:058264180843:listener/app/SAP-dev-alb/09e97bf69c4b5028/602d9f71316c3a00]
module.alb.aws_lb_listener_rule.this["my-https-listener/myapp2-rule"]: Creating...
module.alb.aws_lb_listener_rule.this["my-https-listener/myapp1-rule"]: Creating...
module.alb.aws_lb_listener_rule.this["my-https-listener/myapp1-rule"]: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:058264180843:listener-rule/app/SAP-dev-alb/09e97bf69c4b5028/d87a18f41d72b35c/c8ae391d728653a6]
module.alb.aws_lb_listener_rule.this["my-https-listener/myapp2-rule"]: Creation complete after 2s [id=arn:aws:elasticloadbalancing:us-east-1:058264180843:listener-rule/app/SAP-dev-alb/09e97bf69c4b5028/d87a18f41d72b35c/1e638bac6108764b]

Apply complete! Resources: 60 added, 0 changed, 0 destroyed.

Outputs:

acm_certificate_arn = "arn:aws:acm:us-east-1:058264180843:certificate/a3e49273-ba09-4377-bb57-cf7d99514d2b"
arn = "arn:aws:elasticloadbalancing:us-east-1:058264180843:loadbalancer/app/SAP-dev-alb/09e97bf69c4b5028"
arn_suffix = "app/SAP-dev-alb/09e97bf69c4b5028"
azs = tolist([
  "us-east-1a",
  "us-east-1b",
])
dns_name = "SAP-dev-alb-583181836.us-east-1.elb.amazonaws.com"
ec2_bastion_public_instance_ids = "i-07a9c97a0275dbb9e"
ec2_bastion_public_ip = ""
ec2_private_instance_ids_app1 = [
  "i-09d95ecc1921bfd09",
  "i-09c49ea8d4d698f75",
]
ec2_private_instance_ids_app2 = [
  "i-061a16d20fc45e5a1",
  "i-07d777a2350d59a6c",
]
ec2_private_ip_app1 = [
  "10.0.1.89",
  "10.0.2.123",
]
ec2_private_ip_app2 = [
  "10.0.1.181",
  "10.0.2.124",
]
id = "arn:aws:elasticloadbalancing:us-east-1:058264180843:loadbalancer/app/SAP-dev-alb/09e97bf69c4b5028"
listener_rules = <sensitive>
listeners = <sensitive>
mydomain_name = "devopsmind.shop"
mydomain_zoneid = "Z02832482RAVVTMXRSHAF"
nat_public_ips = tolist([
  "3.94.66.206",
])
private_sg_group_id = "sg-070a700c61d8ac3ea"
private_sg_group_name = "private-sg-20241026191940286100000004"
private_sg_group_vpc_id = "vpc-00be1d8ce78a2a693"
private_subnets = [
  "subnet-000b03c0e4cfd449b",
  "subnet-01a83b2761b6dcb93",
]
public_bastion_sg_group_id = "sg-0cc9a284765c22a51"
public_bastion_sg_group_name = "public-bastion-sg-2024102619194242810000000a"
public_bastion_sg_group_vpc_id = "vpc-00be1d8ce78a2a693"
public_subnets = [
  "subnet-00de5fdafb110217a",
  "subnet-0203b20e9f5ef3b8f",
]
target_groups = {
  "mytg1" = {
    "arn" = "arn:aws:elasticloadbalancing:us-east-1:058264180843:targetgroup/mytg1-20241026191940850500000008/115efdfb3e342bd1"
    "arn_suffix" = "targetgroup/mytg1-20241026191940850500000008/115efdfb3e342bd1"
    "connection_termination" = tobool(null)
    "deregistration_delay" = "10"
    "health_check" = tolist([
      {
        "enabled" = true
        "healthy_threshold" = 3
        "interval" = 30
        "matcher" = "200-399"
        "path" = "/app1/index.html"
        "port" = "traffic-port"
        "protocol" = "HTTP"
        "timeout" = 6
        "unhealthy_threshold" = 3
      },
    ])
    "id" = "arn:aws:elasticloadbalancing:us-east-1:058264180843:targetgroup/mytg1-20241026191940850500000008/115efdfb3e342bd1"
    "ip_address_type" = "ipv4"
    "lambda_multi_value_headers_enabled" = false
    "load_balancer_arns" = toset([])
    "load_balancing_algorithm_type" = "round_robin"
    "load_balancing_anomaly_mitigation" = "off"
    "load_balancing_cross_zone_enabled" = "false"
    "name" = "mytg1-20241026191940850500000008"
    "name_prefix" = "mytg1-"
    "port" = 80
    "preserve_client_ip" = tostring(null)
    "protocol" = "HTTP"
    "protocol_version" = "HTTP1"
    "proxy_protocol_v2" = false
    "slow_start" = 0
    "stickiness" = tolist([
      {
        "cookie_duration" = 86400
        "cookie_name" = ""
        "enabled" = false
        "type" = "lb_cookie"
      },
    ])
    "tags" = tomap({
      "environment" = "dev"
      "owners" = "SAP"
      "terraform-aws-modules" = "alb"
    })
    "tags_all" = tomap({
      "environment" = "dev"
      "owners" = "SAP"
      "terraform-aws-modules" = "alb"
    })
    "target_failover" = tolist([
      {
        "on_deregistration" = tostring(null)
        "on_unhealthy" = tostring(null)
      },
    ])
    "target_group_health" = tolist([
      {
        "dns_failover" = tolist([
          {
            "minimum_healthy_targets_count" = "1"
            "minimum_healthy_targets_percentage" = "off"
          },
        ])
        "unhealthy_state_routing" = tolist([
          {
            "minimum_healthy_targets_count" = 1
            "minimum_healthy_targets_percentage" = "off"
          },
        ])
      },
    ])
    "target_health_state" = tolist([
      {
        "enable_unhealthy_connection_termination" = tobool(null)
        "unhealthy_draining_interval" = tonumber(null)
      },
    ])
    "target_type" = "instance"
    "vpc_id" = "vpc-00be1d8ce78a2a693"
  }
  "mytg2" = {
    "arn" = "arn:aws:elasticloadbalancing:us-east-1:058264180843:targetgroup/mytg2-20241026191940799500000007/78284c16852616f0"
    "arn_suffix" = "targetgroup/mytg2-20241026191940799500000007/78284c16852616f0"
    "connection_termination" = tobool(null)
    "deregistration_delay" = "10"
    "health_check" = tolist([
      {
        "enabled" = true
        "healthy_threshold" = 3
        "interval" = 30
        "matcher" = "200-399"
        "path" = "/app2/index.html"
        "port" = "traffic-port"
        "protocol" = "HTTP"
        "timeout" = 6
        "unhealthy_threshold" = 3
      },
    ])
    "id" = "arn:aws:elasticloadbalancing:us-east-1:058264180843:targetgroup/mytg2-20241026191940799500000007/78284c16852616f0"
    "ip_address_type" = "ipv4"
    "lambda_multi_value_headers_enabled" = false
    "load_balancer_arns" = toset([])
    "load_balancing_algorithm_type" = "round_robin"
    "load_balancing_anomaly_mitigation" = "off"
    "load_balancing_cross_zone_enabled" = "false"
    "name" = "mytg2-20241026191940799500000007"
    "name_prefix" = "mytg2-"
    "port" = 80
    "preserve_client_ip" = tostring(null)
    "protocol" = "HTTP"
    "protocol_version" = "HTTP1"
    "proxy_protocol_v2" = false
    "slow_start" = 0
    "stickiness" = tolist([
      {
        "cookie_duration" = 86400
        "cookie_name" = ""
        "enabled" = false
        "type" = "lb_cookie"
      },
    ])
    "tags" = tomap({
      "environment" = "dev"
      "owners" = "SAP"
      "terraform-aws-modules" = "alb"
    })
    "tags_all" = tomap({
      "environment" = "dev"
      "owners" = "SAP"
      "terraform-aws-modules" = "alb"
    })
    "target_failover" = tolist([
      {
        "on_deregistration" = tostring(null)
        "on_unhealthy" = tostring(null)
      },
    ])
    "target_group_health" = tolist([
      {
        "dns_failover" = tolist([
          {
            "minimum_healthy_targets_count" = "1"
            "minimum_healthy_targets_percentage" = "off"
          },
        ])
        "unhealthy_state_routing" = tolist([
          {
            "minimum_healthy_targets_count" = 1
            "minimum_healthy_targets_percentage" = "off"
          },
        ])
      },
    ])
    "target_health_state" = tolist([
      {
        "enable_unhealthy_connection_termination" = tobool(null)
        "unhealthy_draining_interval" = tonumber(null)
      },
    ])
    "target_type" = "instance"
    "vpc_id" = "vpc-00be1d8ce78a2a693"
  }
}
vpc_cidr_block = "10.0.0.0/16"
vpc_id = "vpc-00be1d8ce78a2a693"
zone_id = "Z35SXDOTRQ7X7K"
>
~~~~


a3e49273-ba09-4377-bb57-cf7d99514d2b
	
devopsmind.shop
	
Amazon Issued
	
Issued






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
 

http://apps.devopsmind.shop
http://apps.devopsmind.shop/app1/index.html
http://apps.devopsmind.shop/app1/metadata.html
http://apps.devopsmind.shop/app2/index.html
http://apps.devopsmind.shop/app2/metadata.html


erro nesta apenas:
http://apps.devopsmind.shop/app2/metadata.html

Not Found

The requested URL was not found on this server.



- Ajustando
/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao10-AWS-ALB-Context-path/manifestos/app2-install.sh
de:
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
para:
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app2/metadata.html



- Apply
 
module.ec2_private_app2["0"].aws_instance.this[0]: Modifying... [id=i-061a16d20fc45e5a1]
module.ec2_private_app2["1"].aws_instance.this[0]: Modifying... [id=i-07d777a2350d59a6c]
module.ec2_private_app2["0"].aws_instance.this[0]: Still modifying... [id=i-061a16d20fc45e5a1, 18s elapsed]
module.ec2_private_app2["1"].aws_instance.this[0]: Still modifying... [id=i-07d777a2350d59a6c, 18s elapsed]
module.ec2_private_app2["1"].aws_instance.this[0]: Still modifying... [id=i-07d777a2350d59a6c, 18s elapsed]
module.ec2_private_app2["0"].aws_instance.this[0]: Still modifying... [id=i-061a16d20fc45e5a1, 18s elapsed]
module.ec2_private_app2["0"].aws_instance.this[0]: Still modifying... [id=i-061a16d20fc45e5a1, 27s elapsed]
module.ec2_private_app2["1"].aws_instance.this[0]: Still modifying... [id=i-07d777a2350d59a6c, 27s elapsed]


erro ainda:
http://apps.devopsmind.shop/app2/metadata.html

Not Found
The requested URL was not found on this server.



- Destroy

module.vpc.aws_internet_gateway.this[0]: Destroying... [id=igw-0cfd3dc99ba245424]
module.vpc.aws_internet_gateway.this[0]: Destruction complete after 1s
module.vpc.aws_vpc.this[0]: Destroying... [id=vpc-00be1d8ce78a2a693]
module.vpc.aws_vpc.this[0]: Destruction complete after 1s

Destroy complete! Resources: 60 destroyed.



# ############################################################################
# ############################################################################
# ############################################################################
# PENDENTE

- Validar que o ajuste dos NS surtiu efeito, apesar do certificado ACM estar ok:
https://dnschecker.org/#NS/devopsmind.shop
<https://dnschecker.org/#NS/devopsmind.shop>

- Retomar apply e testes.

- Checar se o metadata do app2 fica ok, devido ajuste no Shell Script dele:
http://apps.devopsmind.shop/app2/metadata.html