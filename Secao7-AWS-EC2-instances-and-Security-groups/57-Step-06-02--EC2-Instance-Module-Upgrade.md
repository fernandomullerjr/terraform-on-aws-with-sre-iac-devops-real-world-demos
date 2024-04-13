
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "57. Step-06-02: EC2 Instance Module Upgrade."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  57. Step-06-02: EC2 Instance Module Upgrade

### Step-06-03: c7-04-ec2instance-private.tf
- [Example EC2 Instance Module for Reference](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/basic)
```t

# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  name = "${var.environment}-vm"
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/apache-install.sh")
  key_name = var.instance_keypair
  #subnet_id = module.vpc.private_subnets[0] # Single Instance
  vpc_security_group_ids = [module.private_sg.this_security_group_id]    
  instance_count = 3
  subnet_ids = [
    module.vpc.private_subnets[0], 
    module.vpc.private_subnets[1],
    ]
  tags = local.common_tags
}
```
### Step-06-04: c7-02-ec2instance-outputs.tf
```t
# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}
output "ec2_bastion_public_ip" {
  description = "List of Public ip address assigned to the instances"
  value       = module.ec2_public.public_ip
}
# Private EC2 Instances
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private.id
}
output "ec2_private_ip" {
  description = "List of private ip address assigned to the instances"
  value       = module.ec2_private.private_ip
}
```



# ############################################################################
# ############################################################################
# ############################################################################
#  57. Step-06-02: EC2 Instance Module Upgrade

- Removendo o "this_" dos outputs names.

- Atualizar a versão dos módulos utilizados para EC2
version = "5.6.0"


- Na versão anterior era utilizado o "instance_count" para criar várias instancias.
- Agora iremos utilizar o for_each para criar +1 instância EC2.

- Na DOC do módulo "ec2-instance" tem um exemplo de uso do for_each, para criar multiplas EC2:

<https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest>

## Multiple EC2 Instance

~~~~TF
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
~~~~



- Na EC2 privada, será utilizada o set passando os valores 0 e 1:
  for_each = toset(["0", "1"])


- Para a parte de subnet, vai ser usada uma nova função chamada element
<https://developer.hashicorp.com/terraform/language/functions/element>

element Function

element retrieves a single element from a list.

element(list, index)


- Basicamente, ele pega um elemento com base na posição do index.

- Iremos utilizar o "terraform console" para verificar como funciona, utilizando os exemplos

~~~~bash
# ELEMENT Function
# terraform console 
# element(["kalyan", "reddy", "daida"], 0)
# element(["kalyan", "reddy", "daida"], 1)
# element(["kalyan", "reddy", "daida"], 2)
~~~~


element(["kalyan", "reddy", "daida"], 3)
element(["kalyan", "reddy", "daida"], 4)

fernando@debian10x64:~$ terraform console
>

> element(["kalyan", "reddy", "daida"], 0)
"kalyan"
>

>

> element(["kalyan", "reddy", "daida"], 1)
"reddy"
>

>

> element(["kalyan", "reddy", "daida"], 2)
"daida"
>

>

>

> element(["kalyan", "reddy", "daida"], 3)
"kalyan"
>

>

> element(["kalyan", "reddy", "daida"], 4)
"reddy"
>



- Passamos as subnets como argumentos da lista, usando "module.vpc.private_subnets".
- Convertemos as chaves para números, pois originalmente o 0 e o 1 são strings, usamos função "tonumber":
<https://developer.hashicorp.com/terraform/language/functions/tonumber>

- As subnets são obtidas de maneira separada usando o código abaixo:
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))







neste código terraform, como funciona a parte sobre subnet_id ?

~~~~tf
module "ec2_private" {
  depends_on = [ module.vpc ] 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"
  name                   = "${var.environment}-vm"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags

  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
}
~~~~

ChatGPT

Neste código Terraform, a parte relacionada à subnet_id está atribuindo uma sub-rede específica para a instância EC2 que será criada usando o módulo terraform-aws-modules/ec2-instance/aws.

Vamos analisar em detalhes:

    subnet_id: Esta é a ID da sub-rede na qual a instância EC2 será lançada. Cada sub-rede está associada a uma zona de disponibilidade dentro da sua VPC. Ao fornecer a subnet_id, você está especificando em qual zona de disponibilidade a instância será provisionada.

    element(module.vpc.private_subnets, tonumber(each.key)): Aqui está sendo usada uma função element() para buscar a sub-rede da lista module.vpc.private_subnets com base no índice definido pelo loop for_each. O loop for_each = toset(["0", "1"]) itera sobre os elementos "0" e "1", e para cada elemento, ele usa o valor correspondente como índice para selecionar a sub-rede da lista private_subnets dentro do módulo vpc.

Em resumo, o código está configurado para lançar duas instâncias EC2, uma em cada sub-rede privada definida no módulo VPC, utilizando os índices "0" e "1" para selecionar as sub-redes correspondentes. Isso permite distribuir as instâncias em múltiplas zonas de disponibilidade para alta disponibilidade e redundância.






# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO / IMPORTANTE

- Na versão anterior era utilizado o "instance_count" para criar várias instancias. Agora iremos utilizar o for_each para criar +1 instância EC2.

- Função "element", pega um elemento com base na posição do index.