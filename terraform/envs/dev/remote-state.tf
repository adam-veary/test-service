# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `remote-state_override.tf`. Duplicate blocks will be
#   merged.
# Details: https://www.terraform.io/language/files/override


data "terraform_remote_state" "shared-networking" {
  backend = "remote"

  config = {
    hostname = "xometry.scalr.io"
    organization = "scre-prod"
    workspaces = {
      name = "aws_ou_networking-dev-global"
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
