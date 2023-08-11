# Dynamic Credentials Setup
This repository contains the files needed to configure dynamic AWS credentials for Terraform Cloud. 

First, follow the required steps in creating a dedicated GitHub repo and Terraform Cloud workspace. Then, once you have navigated to the respective repo, create a new branch following branch naming standards (USER-STORY-###), and follow the following steps:

1. Clone this repo using [HTTPS URL](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls)
2.	Locate the required configuration files for setting up AWS Dynamic Credentials:
    - ```dynamicCredentials.tf```
    - ```provider.tf```
    - ```variables.tf```
    - ```local.tfvars```
3. Copy the required files to your project repo (following [contributing standards](https://github.com/RealPage-CloudOperations/github/blob/main/README.md#contributing))
4. Update the necessary variable names to match the project name
5. Setup your local machine with AWS credentials to give Terraform permissions for creating IAM roles in AWS
6. Comment out the “Cloud” section of the provider.tf file, then run terraform init and plan to validate the correct IAM role and policy creation 
7. Run terraform apply, then validate the results in AWS 
8. Copy the ARN of the created IAM role and use it to set the ```TFC_AWS_RUN_ROLE_ARN``` variable in TFC
9. Un-comment the “Cloud” section of the provider.tf file 
10. Merge your feature branch with the main branch in GitHub, validate the plan/apply results in Terraform cloud


test change