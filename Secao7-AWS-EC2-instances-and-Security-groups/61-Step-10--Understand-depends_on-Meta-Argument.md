
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "61. Step-10: Understand depends_on Meta-Argument."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  61. Step-10: Understand depends_on Meta-Argument

## Step-10: Usage of depends_on Meta-Argument

### Step-10-01: c7-04-ec2instance-private.tf
- We have put `depends_on` so that EC2 Private Instances will not get created until all the resources of VPC module are created
- **why?**
- VPC NAT Gateway should be created before EC2 Instances in private subnets because these private instances has a `userdata` which will try to go outbound to download the `HTTPD` package using YUM to install the webserver
- If Private EC2 Instances gets created first before VPC NAT Gateway provisioning of webserver in these EC2 Instances will fail.
```t
depends_on = [module.vpc]
```


### Step-10-02: c8-elasticip.tf
- We have put `depends_on` in Elastic IP resource. 
- This elastic ip resource will explicitly wait for till the bastion EC2 instance `module.ec2_public` is created. 
- This elastic ip resource will wait till all the VPC resources are created primarily the Internet Gateway IGW.
```t
depends_on = [module.ec2_public, module.vpc]
```



### Step-10-03: c9-nullresource-provisioners.tf
- We have put `depends_on` in Null Resource
- This Null resource contains a file provisioner which will copy the `private-key/terraform-key.pem` to Bastion Host `ec2_public module created ec2 instance`. 
- So we added explicit dependency in terraform to have this `null_resource` wait till respective EC2 instance is ready so file provisioner can copy the `private-key/terraform-key.pem` file
```t
 depends_on = [module.ec2_public ]
```





# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Usamos o `depends_on` para a EC2, dizendo que ela precisa aguardar a VPC subir.
- Usamos o `depends_on` para o IP Elástico, dizendo que ele precisa aguardar a VPC subir(principalmente o IGW do Internet Gateway) e a EC2 subir também.
- Usamos o `depends_on` para o Null Resource, dizendo que ele precisa aguardar a EC2 subir, para que possam ser executados os comandos e copiados os arquivos.