
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "63. Step-12: Verify EC2, VPC, SG and Connect with SSH."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  63. Step-12: Verify EC2, VPC, SG and Connect with SSH


## Step-12: Connect to Bastion EC2 Instance and Test
```t
# Connect to Bastion EC2 Instance from local desktop
ssh -i private-key/terraform-key.pem ec2-user@<PUBLIC_IP_FOR_BASTION_HOST>

# Curl Test for Bastion EC2 Instance to Private EC2 Instances
curl  http://<Private-Instance-1-Private-IP>
curl  http://<Private-Instance-2-Private-IP>

# Connect to Private EC2 Instances from Bastion EC2 Instance
ssh -i /tmp/terraform-key.pem ec2-user@<Private-Instance-1-Private-IP>
cd /var/www/html
ls -lrta
Observation: 
1) Should find index.html
2) Should find app1 folder
3) Should find app1/index.html file
4) Should find app1/metadata.html file
5) If required verify same for second instance too.
6) # Additionalyy To verify userdata passed to Instance
curl http://169.254.169.254/latest/user-data 

# Additional Troubleshooting if any issues
# Connect to Private EC2 Instances from Bastion EC2 Instance
ssh -i /tmp/terraform-key.pem ec2-user@<Private-Instance-1-Private-IP>
cd /var/log
more cloud-init-output.log
Observation:
1) Verify the file cloud-init-output.log to see if any issues
2) This file (cloud-init-output.log) will show you if your httpd package got installed and all your userdata commands executed successfully or not
```

## Step-13: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
```









# ############################################################################
# ############################################################################
# ############################################################################
#  63. Step-12: Verify EC2, VPC, SG and Connect with SSH


- Plan

~~~~bash

module.ec2_private["1"].aws_instance.this[0]: Refreshing state... [id=i-0a79e9e3765dc238e]
aws_eip.bastion_eip: Refreshing state... [id=eipalloc-021447a51f9502d70]
null_resource.name: Refreshing state... [id=1416821790077800505]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.ec2_public.aws_instance.this[0] has changed
  ~ resource "aws_instance" "this" {
        id                                   = "i-05705c9d087c2a81d"
      + public_dns                           = "ec2-54-209-69-7.compute-1.amazonaws.com"
      + public_ip                            = "54.209.69.7"
        tags                                 = {
            "Name"        = "stag-BastionHost"
            "environment" = "stag"
            "owners"      = "HR"
        }
        # (31 unchanged attributes hidden)

        # (9 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Changes to Outputs:
  ~ ec2_bastion_public_ip           = "" -> "54.209.69.7"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

~~~~



ec2-user


- Teste OK

~~~~BASH
 ┌──────────────────────────────────────────────────────────────────────┐
    │                 • MobaXterm Personal Edition v23.5 •                 │
    │               (SSH client, X server and network tools)               │
    │                                                                      │
    │ ⮞ SSH session to ec2-user@54.209.69.7                                │
    │   • Direct SSH      :  ✓                                             │
    │   • SSH compression :  ✓                                             │
    │   • SSH-browser     :  ✓                                             │
    │   • X11-forwarding  :  ✗  (disabled or not supported by server)      │
    │                                                                      │
    │ ⮞ For more info, ctrl+click on help or visit our website.            │
    └──────────────────────────────────────────────────────────────────────┘

Last login: Sat Apr 20 14:57:50 2024 from XXXXXYYYYYY
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$ ls
[ec2-user@ip-10-0-101-161 ~]$ uname -a
Linux ip-10-0-101-161.ec2.internal 4.14.336-257.568.amzn2.x86_64 #1 SMP Sat Mar 23 09:49:55 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$ curl ifconfig.me
54.209.69.7
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$


[ec2-user@ip-10-0-101-161 ~]$ ls /tmp
systemd-private-c7f18134b83641e38494a80c71b05b5a-chronyd.service-gVx8tu  terraform_170271206.sh  terraform-key.pem
[ec2-user@ip-10-0-101-161 ~]$


~~~~


- Também atualizou o arquivo local:
terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/manifestos/local-exec-output-files/creation-time-vpc-id.txt
VPC created on Sun 14 Apr 2024 05:31:22 PM -03 and VPC ID: vpc-03561e2607cdfe121
VPC created on Sat 20 Apr 2024 11:57:51 AM -03 and VPC ID: vpc-0fde55d20fc96124f



- Testando acesso a EC2 privada:

~~~~bash
[ec2-user@ip-10-0-101-161 ~]$ ls /tmp
systemd-private-c7f18134b83641e38494a80c71b05b5a-chronyd.service-gVx8tu  terraform_170271206.sh  terraform-key.pem
[ec2-user@ip-10-0-101-161 ~]$ ssh -i /tmp/terraform-key.pem 10.0.2.172
The authenticity of host '10.0.2.172 (10.0.2.172)' can't be established.
ECDSA key fingerprint is SHA256:4wi8PzQ42qAL2bnj45Gn/y3ymA+LIOkRun6lr1EaKz0.
ECDSA key fingerprint is MD5:ff:e3:4d:a3:d8:9a:dc:6b:6b:d8:b9:b7:46:3a:9a:0b.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '10.0.2.172' (ECDSA) to the list of known hosts.
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-0-2-172 ~]$ date
Sat Apr 20 17:39:26 UTC 2024
[ec2-user@ip-10-0-2-172 ~]$
~~~~



- Testando o servidor web delas:

~~~~bash
[ec2-user@ip-10-0-2-172 ~]$ exit
logout
Connection to 10.0.2.172 closed.
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$
[ec2-user@ip-10-0-101-161 ~]$ curl 10.0.2.172
<h1>Welcome to StackSimplify - APP-1</h1>
[ec2-user@ip-10-0-101-161 ~]$


[ec2-user@ip-10-0-101-161 ~]$ curl 10.0.1.22
<h1>Welcome to StackSimplify - APP-1</h1>
[ec2-user@ip-10-0-101-161 ~]$


~~~~


# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- É possível utilizar a chave pem via Bastion, na pasta /tmp tem ela:
terraform-key.pem