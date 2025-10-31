provider "aws" {
    region = "us-east-2" # Your AWS region
}

module "state" {
    source = "github.com/AshladBP/devops-lab//td5/scripts/tofu/modules/state-bucket"
    name = "unique-devops-bucket-name" # Replace with a unique name
}