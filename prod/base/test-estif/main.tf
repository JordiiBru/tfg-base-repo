resource "aws_s3_bucket" "estif" {
  bucket = "esitf-lala-1111"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = var.terraform
    Ownership = "estif"
    Stage     = var.stage
  }
}
