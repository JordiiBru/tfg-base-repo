resource "aws_s3_bucket" "bucket_de_prova_1" {
  bucket = "bucket-test-1"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

resource "aws_s3_bucket" "bucket_de_prova_2" {
  bucket = "bucket-test-2"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

resource "aws_route53_zone" "primary_r53" {
  name = "jordibru.cloud"
}

resource "aws_secretsmanager_secret" "example" {
  name = "memoria-tfg-secret"
}






