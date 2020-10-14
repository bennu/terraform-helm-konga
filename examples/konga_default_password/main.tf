module konga {
  source  = "bennu/konga/helm"
  version = "0.0.5"

  db_host = var.db_host
  db_name = var.db_name
  db_pass = var.db_pass
  db_user = var.db_user

  # we can autoconfigure a default connection pass kong_url and if we want also kong_name variables. 
  kong_url = "http://kong:8001"


  # When enable_ingress is true konga is expose whitin an ingress controller, is possible to use annotations also. 
  enable_ingress = true
  # Also configure a hostname for konga
  ingress_host = "konga.dominio.com"

  # Whitin this block user_data we can get parameters to autoconfigure a default administrator user in konga.
  # For example here we can pass a username so when module deploy you can export password.
  # Default user is devops, so here use kongacontrol as username.
  user_data = {
    "username" = "kongacontrol",
  }
}

/*
Need to use postgreSQL Database connection as input
*/
variable db_host {}
variable db_name {}
variable db_user {}
variable db_pass {}

output password {
  sensitive = true
  value = module.konga.password
}