variable "name" {
    description = "The base name for the function and all other resources"
    type = string
    default = "lambda-sample"
}

locals {
  name_with_workspace = "${var.name}-${terraform.workspace}"
}