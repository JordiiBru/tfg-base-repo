resource "aws_s3_bucket" "tfg_states_bucket" {
  bucket = "tfg-terraform-states"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

resource "aws_s3_bucket_policy" "states_bucket_policy" {
  bucket = aws_s3_bucket.tfg_states_bucket.id
  policy = data.aws_iam_policy_document.states_bucket_policy.json
}

data "aws_iam_policy_document" "states_bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_ids["aws-jordi-account"]}:root",
        "arn:aws:iam::${var.account_ids["aws-jordi-account"]}:role/tfg-repo-base-cicd"
      ]
    }

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.tfg_states_bucket.arn}",
      "${aws_s3_bucket.tfg_states_bucket.arn}/*"
    ]
  }

  statement {
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:DeleteBucket"
    ]

    resources = [
      aws_s3_bucket.tfg_states_bucket.arn
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.tfg_states_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tfg_states_versioning" {
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
    Terraform = var.terraform
    Ownership = var.owner
    Stage     = var.stage
  }
}

## for CI/CD testing purposes

# resource "aws_s3_bucket" "test_bucket_testing" {
#   bucket = "testing-actions-lala"

#   tags = {
#     Terraform = var.terraform
#     Ownership = var.owner
#     Stage     = var.stage
#   }
# }