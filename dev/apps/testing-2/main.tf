resource "aws_s3_bucket" "testing_2_lala" {
  bucket = "testing-6-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}
