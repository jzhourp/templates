##############################################################################################
// Terraform cloud variables
##############################################################################################
# Same variables as the ones in local.tfvars
# These variables should be set in TFC
# Leave the default values untouched
variable "tfe_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfe_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFE instance you'd like to use with AWS"
}

variable "tfe_org" {
  type        = string
  default     = ""
  description = "The name of your Terraform Cloud organization"
}

variable "tfe_project_name" {
  type        = string
  default     = "Default Project"
  description = "The project under which a workspace will be created"
}

variable "tfe_workspace_name" {
  type        = string
  default     = "my-aws-workspace"
  description = "The name of the workspace that you'd like to create and connect to AWS"
}

variable "notivus_prod_environment_name" {
  type        = string
  default     = "env"
  description = "Environment Name"
}

