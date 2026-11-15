# SOURCE-TEXT-MARKER-4f9c1e: this line must never appear in the published Pages site.
terraform {
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.6" }
    null   = { source = "hashicorp/null", version = "~> 3.2" }
    local  = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

variable "environment" {
  type    = string
  default = "sandbox"
}

resource "random_pet" "site" {
  length = 2
  prefix = var.environment
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "null_resource" "network" {
  triggers = {
    name = random_pet.site.id
    cidr = "10.0.0.0/16"
  }
}

resource "null_resource" "subnet_a" {
  triggers = {
    network = null_resource.network.id
    cidr    = "10.0.1.0/24"
  }
}

resource "null_resource" "subnet_b" {
  triggers = {
    network = null_resource.network.id
    cidr    = "10.0.2.0/24"
  }
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.txt"
  content  = "${random_pet.site.id}-${random_id.suffix.hex}: ${null_resource.subnet_a.id}, ${null_resource.subnet_b.id}"
}

output "site" {
  value = random_pet.site.id
}

output "network_id" {
  value = null_resource.network.id
}
