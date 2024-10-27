
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "82. Step-02: AWS Certificate Manager Limit Hit."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  82. Step-02: AWS Certificate Manager Limit Hit


## Step-02: Error Message realted AWS ACM Certificate Limit
- Review the AWS Support Case ID 8245155801 to demonstrate the issue and resolution from AWS
- Understand about how to submit the case related to Limit Increase for ACM Certificates.
- It will take 2 to 3 days to increase the limit and resolve the issue from AWS Side so if you want to ensure that before you hit the limit, if you want to increase you can submit the ticket well in advance.
```t
Error: Error requesting certificate: LimitExceededException: Error: you have reached your limit of 20 certificates in the last year.

  on .terraform/modules/acm/main.tf line 11, in resource "aws_acm_certificate" "this":
  11: resource "aws_acm_certificate" "this" {
```

## Step-03: Our Options to Continue
- **Option-1:** Submit the ticket to AWS and wait till they update the ACM certificate limit
- **Option-2:** Switch to other region and continue with our course. 
- This limit you can hit at any point during your next sections of the course where you exceeded 20 times of certificate creation and deletion.
- With that said knowing to run these Terraform Manifests in other region is a better option.
- I will show you the steps you can perform to switch the region using the terraform manifests if you face this issue.
- Use this folder `terraform-manifests-us-east-2` terraform manifests to create resources in us-east-2 region.
- Review `step-04` for changes we need to perform to switch regions. 




- Olhando para as quotas, não parecem ter um limite baixo no momento

<https://us-east-1.console.aws.amazon.com/servicequotas/home/services/acm/quotas>

ACM certificates
	
	
2.500
	
	
Account level
	
ACM certificates created in last 365 days
	
	
5.000
	
	
Account level
	
Domain names per ACM certificate
	
	
10
	
	
Account level
	
Imported certificates
	
	
2.500
	
	
Account level
	
Imported certificates in last 365 days
	
	
5.000
	
	
Account level