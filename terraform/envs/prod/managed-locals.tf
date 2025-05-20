# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `managed-locals_override.tf`. Duplicate blocks will be
#   merged.
# Details: https://www.terraform.io/language/files/override

locals {
  env = "prod"

  managed_aws_tags = {
    "env" : local.env
    "xometry:domain" : "mktp"
    "xometry:terraform-workspace" : "service-test-service-prod"
    "xometry:service" : "test-service"
  }

  managed_kubernetes_labels = {
    "env": local.env
    "xometry.com/terraform-workspace": "service-test-service-prod"
    "xometry.com/domain": "mktp"
  }
}
