locals {
  hostname = var.enable_ingress ? var.ingress_host : ""
  name     = var.name == "" ? format("konga-%s", random_string.konga_name.0.result) : var.name
  password = var.enable_ldap ? "use_ldap" : try(var.user_data["password"], random_string.default_password.result)
  user-default = [{
    "username" : try(var.user_data["username"], "devops"),
    "email" : try(var.user_data["email"], "devops@mail.com"),
    "firstName" : try(var.user_data["firstName"], "Konga"),
    "lastName" : try(var.user_data["lastName"], "Admin"),
    "admin" : true,
    "active" : true,
    "password" : try(var.user_data["password"], random_string.default_password.result),
  }]
  konga_image = var.registry == "" ? var.konga_image : format("%s/%s", var.registry, var.konga_image)
}