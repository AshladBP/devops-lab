terraform {
    backend "s3" {
        bucket = "unique-devops-bucket-name" # Same bucket as above
        key = "td5/scripts/tofu/live/lambda-sample" # Unique key
        region = "us-east-2" # Your AWS region
        encrypt = true
        dynamodb_table = "unique-devops-bucket-name" # Same table as above
    }
}