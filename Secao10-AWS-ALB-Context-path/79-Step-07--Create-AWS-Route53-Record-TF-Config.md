
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "79. Step-07: Create AWS Route53 Record TF Config ."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  79. Step-07: Create AWS Route53 Record TF Config 


## Step-10: c12-route53-dnsregistration.tf
- [Route53 Record Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)
```t
# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  name    = "apps.devopsincloud.com"
  type    = "A"
  alias {
    #name                   = module.alb.this_lb_dns_name
    #zone_id                = module.alb.this_lb_zone_id
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }  
}
```