# test-service Terraform

This directory contains the necessary files to use terraform with the `test-service`
service in this repo. To get started, follow the below information:

## Directory Structure

Inside of the terraform folder, there are multiple subfolders:
* `envs` - Terraform workspaces
  * `prod` - Production Terraform workspace
  * `stage` - Staging Terraform workspace
  * `platform` - Terraform managed resources that are shared across environments (deprecated)
* `modules` - Terraform modules directory
  * `test-service` - test-service module (terraform DBs, SQS queues, S3 buckets, etc.)

Inside of each environment workspace, we have automatically generated several
files: backend.tf, default-providers.tf, managed-ecr.tf, managed-locals.tf, and
remote-state.tf.
  These files are managed by the SRE team via `xomcli platform:init` and allow
  you to access infrastructure, store your terraform state centrally in our
  Terraform Cloud account, and give you access to create/modify/delete your own
  resources.

  These files are not meant to be updated manually and may be overwritten by the
  SRE team or `xomcli platform:init`. If you need to make changes, please use
  a separate file with an `_override` suffix, like `backend_override.tf`.
  Terraform will [merge these together](https://www.terraform.io/language/files/override)
  for you.
