
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "26. Step-02: Input Variables Introduction."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 26. Step-02: Input Variables Introduction

Step-00: Introduction

    v1: Input Variables - Basics
    v2: Provide Input Variables when prompted during terraform plan or apply
    v3: Override default variable values using CLI argument -var
    v4: Override default variable values using Environment Variables
    v5: Provide Input Variables using terraform.tfvars files
    v6: Provide Input Variables using <any-name>.tfvars file with CLI argument -var-file
    v7: Provide Input Variables using auto.tfvars files
    v8-01: Implement complex type constructors like list
    v8-02: Implement complex type constructors like maps
    v9: Implement Custom Validation Rules in Variables
    v10: Protect Sensitive Input Variables
    v11: Understand about File function
