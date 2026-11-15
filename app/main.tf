terraform {
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.6" }
    null   = { source = "hashicorp/null", version = "~> 3.2" }
    local  = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

variable "replicas" {
  type    = number
  default = 2
}

resource "random_password" "db" {
  length  = 20
  special = false
}

resource "null_resource" "database" {
  triggers = {
    engine = "mysql"
  }
}

resource "local_sensitive_file" "db_credentials" {
  filename = "${path.module}/db.conf"
  content  = "host=${null_resource.database.id} password=${random_password.db.result}"
}

resource "null_resource" "service" {
  count = var.replicas
  triggers = {
    database = null_resource.database.id
    replica  = count.index
  }
}

resource "null_resource" "gateway" {
  triggers = {
    backends = join(",", null_resource.service[*].id)
  }
}

output "gateway_id" {
  value = null_resource.gateway.id
}
