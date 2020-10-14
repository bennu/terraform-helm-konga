locals {
  hostname = var.enable_ingress ? var.ingress_host : ""
  name     = var.name == "" ? format("konga-%s", random_string.konga_name.0.result) : var.name
  node-data = [{
    "kong_admin_url" : "${var.kong_url}",
    "name" : "${var.kong_name}",
    "type" : "default"
  }]
  password = var.enable_ldap ? "use_ldap" : try(var.user_data["password"], random_string.default_password.result)
  resources = {
    requests = {
      memory = var.memory_request
      cpu    = var.cpu_request
    }
    limits = {
      memory = var.memory_limit
      cpu    = var.cpu_limit
    }
  }
  user-default = [{
    "username" : try(var.user_data["username"], "devops"),
    "email" : try(var.user_data["email"], "devops@mail.com"),
    "firstName" : try(var.user_data["firstName"], "Konga"),
    "lastName" : try(var.user_data["lastName"], "Admin"),
    "admin" : true,
    "active" : true,
    "password" : try(var.user_data["password"], random_string.default_password.result),
  }]
}