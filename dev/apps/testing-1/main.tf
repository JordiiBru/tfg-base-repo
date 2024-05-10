resource "aws_s3_bucket" "testing_1_lala" {
  bucket = "testing-1-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}
