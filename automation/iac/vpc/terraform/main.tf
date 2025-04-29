terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.96"
        }
    }
    
    required_version = "~> 1.11"
}

provider "aws" {
    region = var.region
}

module "naming" {
    source = "../../commons/naming/terraform"

    org        = var.org
    app        = var.app
    env        = var.env
    region     = var.region
}
