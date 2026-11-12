variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "partner_account_id" {
  description = "A real second AWS account ID used as the cross-account principal"
  type        = string
  default     = "194313865223"
}

variable "org_id" {
  description = "The aws-play AWS Organizations ID"
  type        = string
  default     = "o-4ynr318qmi"
}

variable "lab_az" {
  type    = string
  default = "us-east-2a"
}

variable "enable_costly" {
  description = "io2 multi-attach volumes and an EC2 instance (a few dollars per day)"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "vt" {
  type    = string
  default = null
}
