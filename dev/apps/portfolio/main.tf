module "static" {
  source = "git@github.com:JordiiBru/tf-static-website.git?ref=v0.0.2"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = "portfolio"

  # Custom variables
  bucket_versioning = true
}