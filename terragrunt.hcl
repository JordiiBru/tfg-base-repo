remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket                   = "tfg-terraform-states"
    skip_bucket_root_access  = true
    skip_bucket_enforced_tls = true
    disable_bucket_update    = true

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tfg-terraform-locks"
  }
}

terraform {
  extra_arguments "init_args" {
    commands  = ["init"]
    arguments = ["-reconfigure"]
  }

  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    optional_var_files = [
      "${find_in_parent_folders("account.tfvars", "skip-account-if-does-not-exist")}",
      "${find_in_parent_folders("env.tfvars", "skip-env-if-does-not-exist")}"
    ]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
# This file is managed by `terragrunt.hcl` file from the root folder.
# Any changes here will be lost.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
}

provider "aws" {
  alias  = "north-virginia"
  region = "us-east-1"
}

EOF
}

generate "terragrunt_variables" {
  path      = "terragrunt_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "region" {
  type    = string
  default = ""
}

variable "account_ids" {
  type    = map(string)
  default = {}
}

variable "account_names" {
  type    = map(string)
  default = {}
}

EOF
}