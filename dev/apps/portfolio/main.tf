module "static_portfolio" {
  source = "https://github.com/JordiiBru/tfg-base-repo.git?ref=v0.0.1"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = "portfolio"

  # Custom variables
  bucket_versioning = true
}