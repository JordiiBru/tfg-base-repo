variable "terraform" {
  description = "Infrastructure managed by terraform"
  type        = bool
  default     = true
}

variable "stage" {
  description = "Stage of development"
  type        = string
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
}
