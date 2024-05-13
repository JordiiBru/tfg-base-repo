resource "aws_s3_bucket" "bucket-test" {
  bucket = "testign-2-bucket-lol"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}