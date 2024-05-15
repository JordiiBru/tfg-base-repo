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
