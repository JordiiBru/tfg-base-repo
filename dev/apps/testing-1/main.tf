resource "aws_s3_bucket" "testing_3_lala" {
  bucket = "testing-3-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}
