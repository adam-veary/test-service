# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `backend_override.tf`. Duplicate blocks will be merged.
# Details: https://www.terraform.io/language/files/override

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
    coralogix = {
      source  = "coralogix/coralogix"
      version = ">= 1.18.0, < 2.0.0"
    }
  }
  backend "remote" {
    hostname     = "xometry.scalr.io"
    organization = "xom-prod-commercial"

    workspaces {
      name = "service-test-service-prod"
    }
  }
}
