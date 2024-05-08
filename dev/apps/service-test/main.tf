resource "aws_s3_bucket" "service-test-bucket" {
  bucket = "svc-s3-bucket"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}
