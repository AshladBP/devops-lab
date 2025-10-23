provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "github.com/brikis98/devops-book//ch3/tofu/modules/lambda"

  name = var.name      

  src_dir = "${path.module}/src" 
  runtime = "nodejs20.x"         
  handler = "index.handler"      

  memory_size = 128              
  timeout     = 5                

  environment_variables = {      
    NODE_ENV = "production"
  }
}

module "gateway" {
  source = "github.com/brikis98/devops-book//ch3/tofu/modules/api-gateway?ref=5d56963e698592b7593a877831e0450c62d1191a"

  name               = var.name            
  function_arn       = module.function.function_arn 
  api_gateway_routes = ["GET /"]                    
}
