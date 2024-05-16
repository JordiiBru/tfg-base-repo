resource "aws_s3_bucket" "bucket_de_prova" {
  bucket = "bucket-vulnerable-exemple"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

