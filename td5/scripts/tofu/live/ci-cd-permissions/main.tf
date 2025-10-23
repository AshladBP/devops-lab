provider "aws" {
    region = "us-east-2" # Replace with your desired region
}
module "oidc_provider" {

source = "github.com/AshladBP/devops-lab.git//td5/scripts/tofu/modules/github-aws-oidc?ref=opentofu-tests"

provider_url = "https://token.actions.githubusercontent.com"
}

module "iam_roles" {
    source = "github.com/AshladBP/devops-lab.git//td5/scripts/tofu/modules/gh-actions-iam-roles?ref=opentofu-tests"

    name = "lambda-sample"
    oidc_provider_arn = module.oidc_provider.oidc_provider_arn
    enable_iam_role_for_testing = true
    enable_iam_role_for_plan = true # Add for plan role
    enable_iam_role_for_apply = true # Add for apply role
    lambda_actions = ["lambda:*", "apigateway:*"]
    # TODO: Replace with your own GitHub repo name!

    github_repo = "AshladBP/devops-base" # ex: "bta-devops/cloud-native-devops-kubernetes-2e"

    lambda_base_name = "lambda-sample"
    tofu_state_bucket = "YOUR_S3_BUCKET_NAME" # Replace with your bucket name
    tofu_state_dynamodb_table = "YOUR_DYNAMODB_TABLE_NAME" # Replace with your table name
}
