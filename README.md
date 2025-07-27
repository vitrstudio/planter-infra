# Planter Infra
This project automates the infrastructure deployment of the planter application.

## Terraform States
Three Terraform states are used, they are stored in the vitr-terraform-states S3 bucket:
- hosted-zone (persisted): users/jordivilagut/planter/hosted-zone/terraform.tfstate
- acm (persisted): users/jordivilagut/planter/acm/terraform.tfstate
- infra (ephemeral): users/jordivilagut/planter/infra/terraform.tfstate

## To deploy the whole infrastructure

1. Deploy the hosted zone (just once, after that it will be persisted)
2. Get the NS records from AWS and set them in your domain registrar
3. Deploy the ACM certificates (just once, after that it will be persisted)
4. Commit and push to deploy the modules
