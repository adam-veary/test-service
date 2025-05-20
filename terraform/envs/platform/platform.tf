# DO NOT MODIFY THIS FILE MANUALLY - CHANGES WILL BE OVERWRITTEN.
# This file is managed by xomcli.
# Add your own changes in `platform_override.tf`. Duplicate blocks will be merged.
# Details: https://www.terraform.io/language/files/override

###########################################################################
### These repositories should be considered legacy and should go unused ###
###########################################################################

data "aws_organizations_organization" "master" {
  provider = aws.master
}

data "aws_iam_policy_document" "org_pull_policy" {
  # ###### 'ECR repository policy must block public access' tf scan failure can be dismissed here if the condition block
  # below for PrincipalOrgPaths has not been modified beyond xomcli defaults
  provider = aws.master
  statement {
    sid = "AllowPullFromOrg"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:PrincipalOrgPaths"

      values = [
        "${data.aws_organizations_organization.master.id}/*"
      ]
    }
  }
}

resource "aws_ecr_repository" "test-service_master" {
  provider             = aws.master
  name                 = "test-service"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "test-service_master_policy" {
  provider   = aws.master
  repository = aws_ecr_repository.test-service_master.name
  policy     = data.aws_iam_policy_document.org_pull_policy.json
}

resource "aws_ecr_repository" "test-service_master_cache" {
  # ##### 'ECR images tags shouldn't be mutable' tf scan failure can be dismissed here as this is a CACHE ecr repo
  provider             = aws.master
  name                 = "test-service/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    prune_after_days = 15
  }
}

resource "aws_ecr_repository_policy" "test-service_master_cache_policy" {
  provider   = aws.master
  repository = aws_ecr_repository.test-service_master_cache.name
  policy     = data.aws_iam_policy_document.org_pull_policy.json
}

resource "aws_ecr_repository" "test-service_global_primary" {
  provider             = aws.xomglobal-us-east-1
  name                 = "test-service"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

