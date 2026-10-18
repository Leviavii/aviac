variable "name" {
  type = string
}

variable "image" {
  type = string
}

locals {
  container_definition = {
    name      = var.name
    image     = var.image
    essential = true
  }
}

output "json_map_encoded_list" {
  value = jsonencode([local.container_definition])
}
