provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "github.com/AshladBP/devops-lab.git//td5/scripts/tofu/modules/lambda"

  name = local.name_with_workspace      

  src_dir = "${path.module}/src" 
  runtime = "nodejs20.x"         
  handler = "index.handler"      

  memory_size = 128              
  timeout     = 5                

 environment_variables = {
    NODE_ENV = "production"
    ENV_NAME = terraform.workspace
  }
}

module "gateway" {
  source = "github.com/AshladBP/devops-lab.git//td5/scripts/tofu/modules/api-gateway"

  name               = local.name_with_workspace            
  function_arn       = module.function.function_arn 
  api_gateway_routes = ["GET /"]                    
}
