resource "aws_s3_bucket" "tfg_states_bucket" {
  bucket = "tfg-terraform-states"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = true
    Owner     = var.owner
    Stage     = var.stage
  }
}

resource "aws_s3_bucket_policy" "tfg_states_bucket_policy" {
  bucket = aws_s3_bucket.tfg_states_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::390844767079:root",
            "arn:aws:iam::390844767079:user/jordi.bru",
            "arn:aws:iam::390844767079:role/tfg-repo-base-cicd"
          ]
        },
        "Action" : [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        "Resource" : [
          "${aws_s3_bucket.tfg_states_bucket.arn}",
          "${aws_s3_bucket.tfg_states_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "states_access_block" {
  bucket = aws_s3_bucket.tfg_states_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "states_versioning" {
  bucket = aws_s3_bucket.tfg_states_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tfg_tf_locks" {
  name                        = "tfg-terraform-locks"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "LockID"
  deletion_protection_enabled = true

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform = true
    Owner     = var.owner
    Stage     = var.stage
  }
}