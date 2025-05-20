# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `managed-build-artifacts-ecr_override.tf`. Duplicate
#   blocks will be merged.
# Details: https://www.terraform.io/language/files/override

module "ecr" {
  source  = "xometry.scalr.io/acc-v0oegra2vkqd3nn90/standardized-ecr/aws"
  version = "~>1.0"

  providers = {
    aws = aws.build-artifacts
  }

  repository_name = "test-service"

  default_tags = local.managed_aws_tags
}

module "ecr-cache" {
  source  = "xometry.scalr.io/acc-v0oegra2vkqd3nn90/standardized-ecr/aws"
  version = "~>1.0"
  providers = {
    aws = aws.build-artifacts
  }

  repository_name = "test-service/cache"

  default_tags = local.managed_aws_tags
}

