output password {
  description = "Password for default user, valid when LDAP is disable"
  sensitive = true
  value     = local.password
}

output hostname {
  description = "Konga hostname"
  value     = local.hostname
}