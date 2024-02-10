provider "aws" {
  # Região onde seus recursos serão provisionados
  region = "us-east-1"
  #profile = "sandbox-fernando-labs/AdministratorAccess"

    assume_role {
    role_arn     = "arn:aws:iam::058264180843:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_7b1a64e40dd9fda5"
    session_name = "terraform-session"
  }
}
