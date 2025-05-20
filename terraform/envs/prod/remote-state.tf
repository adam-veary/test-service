# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `remote-state_override.tf`. Duplicate blocks will be
#   merged.
# Details: https://www.terraform.io/language/files/override

data "terraform_remote_state" "infra" {
  backend = "remote"

  config = {
    hostname = "xometry.scalr.io"
    organization = "env-v0of1a1uncr1sasm6" # xom-prod-gov Environment in scalr
    workspaces = {
      name = "xometry_terraform-sacred-infra-prod"
    }
  }
}

data "terraform_remote_state" "shared-networking" {
  backend = "remote"

  config = {
    hostname = "xometry.scalr.io"
    organization = "scre-prod"
    workspaces = {
      name = "aws_ou_networking-prod-global"
    }
  }
}

data "terraform_remote_state" "aws_ou_accounts-global" {
  backend = "remote"

  config = {
    hostname = "xometry.scalr.io"
    organization = "scre-prod"
    workspaces = {
      name = "aws_ou_accounts-global"
    }
  }
}

data "terraform_remote_state" "aws_ou_accounts-govcloud" {
  backend = "remote"

  config = {
    hostname = "xometry.scalr.io"
    organization = "scre-prod"
    workspaces = {
      name = "aws_ou_accounts-govcloud"
    }
  }
}
