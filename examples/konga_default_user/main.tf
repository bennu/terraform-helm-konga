module konga {
  source  = "../../"

  db_host = var.db_host
  db_name = var.db_name
  db_pass = var.db_pass
  db_user = var.db_user

  # We can use another namespace to deploy all components, only need to secure that is exists.
  namespace = "konga"

  # We can use another namespace to deploy all components, only need to secure that is exists.
  enable_ingress = true

  # Whitin this block user_data we can get parameters to autoconfigure a default administrator user in konga.
  # For example here we can pass a username so when module deploy you can export password.
  # Default user is devops.
  # Here also we can modify another parameters as: "username", "email", "firstName", "lastName" and "password".
  user_data = {
    "password" = var.password,
    "email"    = "it@company.com",
  }
}

/*
Need to use postgreSQL Database connection as input
*/
variable db_host {}
variable db_name {}
variable db_user {}
variable db_pass {}

# use for pass password for user konga
variable password {}

output password {
  sensitive = true
  value = module.konga.password
}
