terraform {
    backend "s3" {
        bucket = "unique-devops-bucket-name" # Replace
        key = "td5/scripts/tofu/live/tofu-state"
        region = "us-east-2" # Your AWS region
        encrypt = true
        dynamodb_table = "unique-devops-bucket-name" # Replace
    }
}