provider "aws" {
    region = "us-east-2" # Or your preferred region
}
module "child_accounts" {

    source = "github.com/AshladBP/devops-lab//td6/tofu/modules/aws-organizations"
    create_organization = true # Set to false if you already enabled AWS Organizations
    dev_account_email = "nassim.mahnane+dev@edu.esiee.fr" # Replace with your email alias
    stage_account_email = "nassim.mahnane+stage@edu.esiee.fr" # Replace with your email alias
    prod_account_email = "nassim.mahnane+prod@edu.esiee.fr" # Replace with your email alias
}