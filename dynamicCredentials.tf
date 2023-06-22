##############################################################################################
// Dynamic Credentials for TFE AWS Provider - ACC
##############################################################################################
// Code referenced: https://github.com/hashicorp/terraform-dynamic-credentials-setup-examples
# Data source used to grab the TLS certificate for Terraform Cloud.
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate
data "tls_certificate" "tfe_certificate" {
  url = "https://${var.tfe_hostname}"
}

# Creates an OIDC provider which is restricted to
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
resource "aws_iam_openid_connect_provider" "tfe_provider" {
  url             = data.tls_certificate.tfe_certificate.url
  client_id_list  = [var.tfe_aws_audience]
  thumbprint_list = [data.tls_certificate.tfe_certificate.certificates[0].sha1_fingerprint]
}

# Creates a role which can only be used by the specified Terraform
# cloud workspace.
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "tfe_role" {
  name = "tfe-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
       "Federated": "${aws_iam_openid_connect_provider.tfe_provider.arn}"
     },
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": {
       "StringEquals": {
         "${var.tfe_hostname}:aud": "${one(aws_iam_openid_connect_provider.tfe_provider.client_id_list)}"
       },
       "StringLike": {
         "${var.tfe_hostname}:sub": "organization:${var.tfe_org}:project:${var.tfe_project_name}:workspace:${var.tfe_workspace_name}:run_phase:*"
       }
     }
   }
 ]
}
EOF
}

# Creates a policy that will be used to define the permissions that
# the previously created role has within AWS.
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "tfe_policy" {
  name        = "tfe-policy"
  description = "TFE run policy"

  policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Action": [
       "s3:ListBucket"
     ],
     "Resource": "*"
   }
 ]
}
EOF
}

# Creates an attachment to associate the above policy with the
# previously created role.
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "tfe_policy_attachment" {
  role       = aws_iam_role.tfe_role.name
  policy_arn = aws_iam_policy.tfe_policy.arn
}

// Attaching read only managed policy
resource "aws_iam_role_policy_attachment" "tfe_ro_policy_attachment" {
  role       = aws_iam_role.tfe_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}




