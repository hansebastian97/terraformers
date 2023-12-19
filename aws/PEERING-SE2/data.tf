data "aws_kms_secrets" "credentials" {
  secret {
    # ... potentially other configuration ...
    name    = "cred"
    payload = file("${path.module}/credentials.yml.encrypted")
  }
}

locals {
  credentials = yamldecode(data.aws_kms_secrets.credentials.plaintext["cred"])
}