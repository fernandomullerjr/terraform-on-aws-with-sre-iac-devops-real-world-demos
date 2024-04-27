
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "67. Step-04: Added new SG Rule 81."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  67. Step-04: Added new SG Rule 81


## Step-06: Update c5-05-securitygroup-loadbalancersg.tf 
```t
  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow Port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ] 
```












# ############################################################################
# ############################################################################
# ############################################################################
#  67. Step-04: Added new SG Rule 81

<https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/5.1.0>

- Exemplo do "ingress_with_cidr_blocks" do módulo security-group:

~~~~tf
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
~~~~


- Pegando o example de complete, ao acessar o main.tf do example complete, temos mais exemplos de como criar as rules:

<https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/v5.1.0/examples/complete/main.tf>

~~~~tf
module "complete_sg" {
  source = "../../"

  name        = "complete-sg"
  description = "Security group with all available arguments set (this is just an example)"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Cash       = "king"
    Department = "kingdom"
  }

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0,2.2.2.2/32"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_blocks = "10.10.0.0/20"
    },
  ]

~~~~




## Step-08: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```


Destroy complete! Resources: 44 destroyed.






# ############################################################################
# ############################################################################
# ############################################################################
#  RESUMO

- Quando tem uma rule com nome "postgresql-tcp" num módulo "security-group", trata-se das default rules, que tem na caixa de seleção ao criar uma rule numa SG
Exemplo: SSH, SMTP, DNS, etc

- Além de utilizar as rules default com o módulo "security-group", é possível criar rules personalizadas, informando as portas, protocol, descrição, cidr block, etc.