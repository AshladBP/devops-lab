provider "aws" {
    region = "us-east-2" # Your AWS region
}

module "state" {
    source = "github.com/AshladBP/devops-lab//td5/scripts/tofu/modules/state-bucket"
    name = "UNIQUE-DEVOPS-BUCKET" # Replace with a unique name
}