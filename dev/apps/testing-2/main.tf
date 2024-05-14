resource "aws_s3_bucket" "testing_1_lala" {
  bucket = "testing-1-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

resource "aws_s3_bucket" "testing_2_lala" {
  bucket = "testing-3-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}
