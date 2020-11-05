module konga {
  source  = "bennu/konga/helm"
  version = "0.0.8"

  db_host   = var.db_host
  db_name   = var.db_name
  db_pass   = var.db_pass
  db_user   = var.db_user
  namespace = "management"
  kong_url  = "http://kong.kong.svc:8001"

  enable_ingress = true
  ingress_host   = "konga.bennu.cl"

  # Is possible to use another chart from konga, here we can fork of officially.
  # we can use a custom chart whit some values that are not defined as part of block values
  chart_repository = "https://charts.bennu.cl"

  # using dynamic values configured as chart_extra_set_configs, we can set values.
  # e.g.: we configure a job to prepare a database to postgreSQL with "runMigrations = true"
  chart_extra_set_configs = [
    { "name" = "runMigrations", "value" = true },
  ]

  # this controls the values ​​for main user
  user_data = {
    "username" = "bennuid",
    "password" = "secrets",
  }
}

/*
Need to use postgreSQL Database connection as input
*/
variable db_host {}
variable db_name {}
variable db_user {}
variable db_pass {}
