
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "20. Step-04: Part-2: Implement Provider Block."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 20. Step-04: Part-2: Implement Provider Block


## Authentication and Configuration
<https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication>

Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:

    Parameters in the provider configuration
    Environment variables
    Shared credentials files
    Shared configuration files
    Container credentials
    Instance profile credentials and Region




## Credentials

- Autenticando via chaves AWS
Credentials can be provided by adding an access_key, secret_key, and optionally token, to the aws provider block.

Usage:

~~~~TF
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
~~~~




## Environment Variables

Credentials can be provided by using the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and optionally AWS_SESSION_TOKEN environment variables. The Region can be set using the AWS_REGION or AWS_DEFAULT_REGION environment variables.

For example:

~~~~TF
provider "aws" {}
~~~~

~~~~BASH
% export AWS_ACCESS_KEY_ID="anaccesskey"
% export AWS_SECRET_ACCESS_KEY="asecretkey"
% export AWS_REGION="us-west-2"
% terraform plan
~~~~




## Shared Configuration and Credentials Files

The AWS Provider can source credentials and other settings from the shared configuration and credentials files. By default, these files are located at $HOME/.aws/config and $HOME/.aws/credentials on Linux and macOS, and "%USERPROFILE%\.aws\config" and "%USERPROFILE%\.aws\credentials" on Windows.

If no named profile is specified, the default profile is used. Use the profile parameter or AWS_PROFILE environment variable to specify a named profile.

The locations of the shared configuration and credentials files can be configured using either the parameters shared_config_files and shared_credentials_files or the environment variables AWS_CONFIG_FILE and AWS_SHARED_CREDENTIALS_FILE.

For example:

~~~~TF
provider "aws" {
  shared_config_files      = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/Users/tf_user/.aws/creds"]
  profile                  = "customprofile"
}
~~~~



# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

- If no named profile is specified, the default profile is used.