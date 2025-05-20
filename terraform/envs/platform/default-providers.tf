# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `providers_override.tf`. Duplicate blocks will be merged.
# Details: https://www.terraform.io/language/files/override

locals {
  ou_account_assume_role_name        = "TerraformAssumeRole"
  domains_global_account_id_param    = "/xometry/accounts/global/XometryDomainsDevEngineering"
  domains_gov_account_id_param       = "/xometry/accounts/govcloud/XometryGovDomainsDevEngineering"
  managed_global_cluster             = "managed-global-${local.env}"
  domains_ds_global_account_id_param = "/xometry/accounts/global/XometryDomainsDevDataScience"
  domains_ds_gov_account_id_param    = "/xometry/accounts/govcloud/XometryGovDomainsDevDataScience"
  build_artifacts_id_param           = "/xometry/accounts/global/XometryGlobalBuildArtifacts"
  build_artifacts_gov_id_param       = "/xometry/accounts/govcloud/XometryBuildArtifacts"
  domains_f4_gov_account_id          = "/xometry/accounts/govcloud/XometryGovDomainsProdFactoryFour"
  domains_f4_prod_account_id         = "/xometry/accounts/global/XometryDomainsProdFactoryFour"
  domains_f4_stage_account_id        = "/xometry/accounts/global/XometryDomainsStageFactoryFour"
}

################################################################################
# Xometry Master account (384070809049)
################################################################################

variable "master_aws_access_key" {
  type        = string
  description = "AWS Access Key ID for the Master Production Account"
}

variable "master_aws_secret_key" {
  type        = string
  description = "AWS Access Key Secret for the XomUS Production Account"
}

provider "aws" {
  alias      = "master"
  region     = "us-west-2"
  access_key = var.master_aws_access_key
  secret_key = var.master_aws_secret_key

  default_tags {
    tags = local.managed_aws_tags
  }
}

################################################################################
# Xomglobal account (063425698216)
################################################################################

variable "global_aws_access_key" {
  type        = string
  description = "AWS Access Key ID for the XomGlobal Dev Account"
}

variable "global_aws_secret_key" {
  type        = string
  description = "AWS Access Key Secret for the XomGlobal Dev Account"
}

data "aws_ssm_parameter" "build_artifacts_account_id" {
  provider = aws.master
  name     = local.build_artifacts_id_param
}

provider "aws" {
  alias      = "build-artifacts"
  region     = "us-east-2"
  access_key = var.master_aws_access_key
  secret_key = var.master_aws_secret_key
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_ssm_parameter.build_artifacts_account_id.value}:role/${local.ou_account_assume_role_name}"
  }

  default_tags {
    tags = local.managed_aws_tags
  }
}

provider "aws" {
  alias      = "xomglobal-us-east-1"
  region     = "us-east-1"
  access_key = var.global_aws_access_key
  secret_key = var.global_aws_secret_key

  default_tags {
    tags = local.managed_aws_tags
  }
}



################################################################################
# Coralogix
################################################################################

// Not used by services running in kubernetes; logs/metrics are handled by
// otel-collector pods there. May be needed for e.g. AWS EventBridge.
variable "coralogix_send_api_key" {
  type        = string
  description = "Send-your-data API key to send logs/metrics directly to Coralogix (for e.g. SDKs, AWS services)"
}

variable "coralogix_tf_api_key" {
  type        = string
  description = "API key to use in Coralogix TF provider, for creating Coralogix resources (e.g. alerts)"
}

provider "coralogix" {
  api_key = var.coralogix_tf_api_key
  env     = "USA1"
}
