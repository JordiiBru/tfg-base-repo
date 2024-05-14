resource "aws_s3_bucket" "testing_2_lala" {
  bucket = "testing-55-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

resource "aws_s3_bucket" "testing_5_lala" {
  bucket = "testing-44-lala-lala"

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

