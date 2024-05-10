config {
  plugin_dir       = "~/.tflint.d/plugins"
}

plugin "terraform" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  version = "0.7.0"
}

plugin "aws" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.31.0"
}