
terraform {
  backend "s3" {
    bucket = "tct-infra-state-97425"
    key    = "terraform/eu-central-1/ecs-cluster"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
