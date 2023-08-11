##############################################################################################
// Local variables for setting up AWS Dynamic Credentials
##############################################################################################
# Use the following local variables for running terraform locally 
# Add this file to .gitignore if it is not already ignored
# Declare variables in TFC instead
tfe_aws_audience         = aws.workload.identity
tfe_hostname             = "app.terraform.io"
tfe_org                  = "RealPage-CloudOps"
tfe_project_name         = "AWS Accounts"
tfe_workspace_name       = "[ACC-ENV]"
ACC-ENV_environment_name = "[ENV]"