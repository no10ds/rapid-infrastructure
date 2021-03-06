terraform {
  backend "s3" {
    key = "ecr/terraform.tfstate"
  }
}

data "terraform_remote_state" "s3-state" {
  backend = "s3"

  config = {
    key    = "s3/terraform.tfstate"
    bucket = var.state_bucket
  }
}

resource "aws_ecr_repository" "private" {
  #checkov:skip=CKV_AWS_51:No need for immutable tags
  name                 = "data-f1-registry"
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "public" {
  provider = aws.us_east_1

  repository_name = "api"

  catalog_data {
    about_text    = "Please see https://github.com/no10ds/rapid-infrastructure/ for more information"
    architectures = ["x86-64"]
    description   = "Project rAPId API Image"
    # TODO: Add image
    # logo_image_blob   = filebase64(image.png)
    operating_systems = ["Linux"]
    usage_text        = "Please see https://github.com/no10ds/rapid-infrastructure/ for details on the use"
  }
}
