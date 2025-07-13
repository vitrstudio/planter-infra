#Planter Infra
This project automates the infrastructure deployment of the planter application

## To deploy the whole infrastructure

1. Deploy the hosted zone (just once, after that it will be persisted)
2. Get the NS records from AWS and set them in your domain registrar
3. Get the hosted zone ID from AWS and set it on the ci/cd file (deploy.yml)
4. Commit and push to deploy the modules
