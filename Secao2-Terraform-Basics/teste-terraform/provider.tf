provider "aws" {
  # Região onde seus recursos serão provisionados
  region = "us-east-1"

  profile = "fernandomullerjunior-labs/AdministratorAccess"

    assume_role {
    role_arn     = "arn:aws:iam::058264180843:role/admin-role-account-sandbox"
    # (Optional) The external ID created in step 1c.
    external_id = "7755"
    session_name = "terraform-session"
  }
}
