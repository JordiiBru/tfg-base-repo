resource "aws_s3_bucket" "buecket_testing" {
  bucket = "lala-2-bucket-test"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

