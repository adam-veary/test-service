# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `managed-ecr_override.tf`. Duplicate blocks will be merged.
# Details: https://www.terraform.io/language/files/override




locals {
  k8s_global_account_id_param = "/xometry/accounts/global/XometryKubernetesStage"
  k8s_gov_account_id_param    = "/xometry/accounts/govcloud/XometryGovKubernetesStage"
}

resource "aws_ecr_repository" "global-domains-engineering-us-east-2-test-service" {
  provider             = aws.global-domains-engineering-us-east-2
  name                 = "test-service"
  image_tag_mutability = "IMMUTABLE"
  

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "global-domains-engineering-us-east-2-test-service" {
  provider   = aws.global-domains-engineering-us-east-2
  repository = aws_ecr_repository.global-domains-engineering-us-east-2-test-service.name
  policy     = data.aws_iam_policy_document.global-domains-engineering-us-east-2-test-service.json
}

data "aws_ssm_parameter" "k8s_global_account_id" {
  provider = aws.master
  name     = local.k8s_global_account_id_param
}

data "aws_iam_policy_document" "global-domains-engineering-us-east-2-test-service" {
  provider = aws.global-domains-engineering-us-east-2
  statement {
    sid = "AllowReadFromKubernetesAcct"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]

    principals {
      type        = "AWS"
      identifiers = [data.aws_ssm_parameter.k8s_global_account_id.value]
    }
  }
}

