
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "36. Step-04: Implement AZ Datasource and for_each Meta-Argument."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 36. Step-04: Implement AZ Datasource and for_each Meta-Argument

- Página sobre esta parte da seção:
<https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/05-Terraform-Loops-MetaArguments-SplatOperator/05-02-MetaArgument-for_each>