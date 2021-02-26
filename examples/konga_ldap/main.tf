module konga {
  source = "../../"

  db_host = var.db_host
  db_name = var.db_name
  db_pass = var.db_pass
  db_user = var.db_user

  kong_endpoints = [
    {
      "kong_admin_url" = "http://kong:8001",
      "name"           = "konga",
      "type"           = "default"
    },
  ]

  # When enable_ingress is true konga is expose whitin an ingress controller, is possible to use annotations also.
  # So, defining hostname with ingress_host value.
  enable_ingress = true
  ingress_host   = "qa.konga.local"

  # We can use another namespace to deploy all components, only need to secure that is exists.
  namespace = "qa"

  # When enable_ldap is true, default user is not able, so only can login with a ldap credential,
  # so, we can define something values as needed for connect to our ldap server.
  enable_ldap            = "true"
  ldap_host              = "ldap://example.com:389"
  ldap_bind_dn           = "administrator"
  ldap_bind_pass         = var.ldap_bind_pass
  ldap_user_search_base  = "dc=users,dc=example,dc=com"
  ldap_group_search_base = "dc=groups,dc=example,dc=com"
  ldap_group_reg         = "^(konga)$"
}

/*
Need to use postgreSQL Database connection as input
*/
variable db_host {}
variable db_name {}
variable db_user {}
variable db_pass {}

# Use for input bind pass as prompt
variable ldap_bind_pass {}

# Here we can show a beauty value :)
output password {
  sensitive = true
  value     = module.konga.password
}