
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "59. Step-08: Create Null Resource and Connection Block."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  59. Step-08: Create Null Resource and Connection Block

## Step-08: c9-nullresource-provisioners.tf

### Step-08-01: Define null resource in c1-versions.tf

- Learn about [Terraform Null Resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- Define null resource in c1-versions.tf in `terraform block`

```tf
    null = {
      source = "hashicorp/null"
      version = "~> 3.0.0"
    }    
```


## Provider - Versions

- Ajustar o arquivo c1-versions.tf
incluir o provider null

terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/c1-versions.tf

código ajustado:

~~~~tf
# Terraform Block
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

~~~~







## null_resource

<https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource>

null_resource

The null_resource resource implements the standard resource lifecycle but takes no further action. On Terraform 1.4 and later, use the terraform_data resource type instead.

The triggers argument allows specifying an arbitrary set of values that, when changed, will cause the resource to be replaced.

~~~~tf
resource "aws_instance" "cluster" {
  count         = 3
  ami           = "ami-0dcc1e21636832c5d"
  instance_type = "m5.large"

  # ...
}

# The primary use-case for the null resource is as a do-nothing container
# for arbitrary actions taken by a provisioner.
#
# In this example, three EC2 instances are created and then a
# null_resource instance is used to gather data about all three
# and execute a single action that affects them all. Due to the triggers
# map, the null_resource will be replaced each time the instance ids
# change, and thus the remote-exec provisioner will be re-run.
resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster[*].id)
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = element(aws_instance.cluster[*].public_ip, 0)
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "bootstrap-cluster.sh ${join(" ",
      aws_instance.cluster[*].private_ip)}",
    ]
  }
}
~~~~


- Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>

- O Terraform 1.4 introduziu o recurso terraform_data, que oferece funcionalidades semelhantes ao null_resource com algumas vantagens, como simplicidade e melhor integração com o Terraform Cloud.



- Manifesto obtido do zip

~~~~tf
# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }  

## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
/*  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }  
  */

}

# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)
~~~~






## Provisioners

<https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax>

Provisioners

You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.


### Provisioners are a Last Resort

    Hands-on: Try the Provision Infrastructure Deployed with Terraform tutorials to learn about more declarative ways to handle provisioning actions.

Terraform includes the concept of provisioners as a measure of pragmatism, knowing that there are always certain behaviors that cannot be directly represented in Terraform's declarative model.

However, they also add a considerable amount of complexity and uncertainty to Terraform usage. Firstly, Terraform cannot model the actions of provisioners as part of a plan because they can in principle take any action. Secondly, successful use of provisioners requires coordinating many more details than Terraform usage usually requires: direct network access to your servers, issuing Terraform credentials to log in, making sure that all of the necessary external software is installed, etc.

The following sections describe some situations which can be solved with provisioners in principle, but where better solutions are also available. We do not recommend using provisioners for any of the use-cases described in the following sections.

Even if your specific use-case is not described in the following sections, we still recommend attempting to solve it using other techniques first, and use provisioners only if there is no other option.


- Evitar utilizar provisioner, provisioner são o último recurso em alguns casos.


### O que são Provisioners?

Provisioners no Terraform são ferramentas poderosas que permitem executar tarefas específicas em máquinas locais ou remotas após o provisionamento da infraestrutura. Isso facilita a configuração e a preparação de servidores, bancos de dados e outros recursos para atender às necessidades do seu aplicativo.

Benefícios dos Provisioners:

    Automação: Simplificam o processo de configuração manual, reduzindo o tempo e o risco de erros.
    Repetibilidade: Garantem que todos os ambientes sejam configurados de forma consistente, independentemente do local ou da equipe.
    Gerenciamento de Configuração: Permitem a instalação de software, a criação de usuários e a aplicação de configurações específicas em cada máquina.

Exemplos de Uso de Provisioners:

    Instalação de pacotes de software (ex: Apache, Nginx, MySQL)
    Configuração de firewalls e regras de segurança
    Criação de usuários e grupos
    Montagem de sistemas de arquivos
    Inicialização de scripts personalizados

Devo evitar os Provisioners?

Embora os provisioners ofereçam diversos benefícios, existem algumas situações em que é recomendável evitá-los:

    Complexidade: Provisioners complexos podem dificultar a leitura e a manutenção do código Terraform.
    Depuração: Resolver problemas em provisioners pode ser mais desafiador do que em outras abordagens.
    Segurança: Executar scripts em máquinas pode introduzir riscos de segurança se não forem devidamente protegidos.

Alternativas aos Provisioners:

    Módulos Terraform: Pacotes reutilizáveis ​​de código Terraform que encapsulam lógica de provisionamento complexa.
    Ferramentas de Configuração como Ansible, Chef ou Puppet: Automatizam a configuração de infraestrutura e aplicativos de maneira declarativa.
    Cloud-init: Uma ferramenta nativa para provisionamento de instâncias na nuvem, como AWS e GCP.




## File provisioner

<https://developer.hashicorp.com/terraform/language/resources/provisioners/file>
File Provisioner

The file provisioner copies files or directories from the machine running Terraform to the newly created resource. The file provisioner supports both ssh and winrm type connections.

Important: Use provisioners as a last resort. There are better alternatives for most situations. Refer to Declaring Provisioners for more details.

Example usage

~~~~tf
resource "aws_instance" "web" {
  # ...

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "conf/myapp.conf"
    destination = "/etc/myapp.conf"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/file.log"
  }

  # Copies the configs.d folder to /etc/configs.d
  provisioner "file" {
    source      = "conf/configs.d"
    destination = "/etc"
  }

  # Copies all files and folders in apps/app1 to D:/IIS/webapp1
  provisioner "file" {
    source      = "apps/app1/"
    destination = "D:/IIS/webapp1"
  }
}
~~~~





# ############################################################################
# ############################################################################
# ############################################################################
# PENDENTE

- Continua em
06:21

- VER SOBRE
Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>

- Efetuar testes com
https://developer.hashicorp.com/terraform/language/resources/terraform-data

- Ver mais sobre provisioners
https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax




## connection

- Ao utilizar o file provisioner, é necessário configurar a conexão
a conexão é configurada no trecho "connection", conforme o exemplo abaixo

<https://developer.hashicorp.com/terraform/language/resources/provisioners/connection>

Example usage

~~~~tf
# Copies the file as the root user using SSH
provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "/etc/myapp.conf"

  connection {
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
}

# Copies the file as the Administrator user using WinRM
provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "C:/App/myapp.conf"

  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}"
    host     = "${var.host}"
  }
}
~~~~






## Provisioners Without a Resource

<https://developer.hashicorp.com/terraform/language/resources/provisioners/null_resource>

If you need to run provisioners that aren't directly associated with a specific resource, you can associate them with a terraform_data.

Instances of terraform_data are treated like normal resources, but they don't do anything. Like with any other resource type, you can configure provisioners and connection details on a terraform_data resource. You can also use its input argument, triggers_replace argument, and any meta-arguments to control exactly where in the dependency graph its provisioners will run.

Important: Use provisioners as a last resort. There are better alternatives for most situations. Refer to Declaring Provisioners for more details.

Example usage

~~~~tf
resource "aws_instance" "cluster" {
  count = 3

  # ...
}

resource "terraform_data" "cluster" {
  # Replacement of any instance of the cluster requires re-provisioning
  triggers_replace = aws_instance.cluster.[*].id

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.cluster.[0].public_ip
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "bootstrap-cluster.sh ${join(" ", aws_instance.cluster.*.private_ip)}",
    ]
  }
}
~~~~


# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- Evitar utilizar provisioner, provisioner são o último recurso em alguns casos.

- Nas versões mais atuais do Terraform o null resource foi substituido pelo terraform_data Managed Resource Type
On Terraform 1.4 and later, use the terraform_data resource type instead.
<https://developer.hashicorp.com/terraform/language/resources/terraform-data>

- O Terraform 1.4 introduziu o recurso terraform_data, que oferece funcionalidades semelhantes ao null_resource com algumas vantagens, como simplicidade e melhor integração com o Terraform Cloud.
