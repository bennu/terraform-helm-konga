resource random_string konga_name {
  count   = var.name == "" ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource random_string token_secret {
  length  = 28
  special = false
}

resource random_string default_password {
  length  = 28
  special = false
}

resource kubernetes_secret node_data {
  metadata {
    name      = "kong-node-data"
    namespace = var.namespace
  }

  data = {
    "node-data" = <<EOF
        module.exports = ${jsonencode(var.kong_endpoints)}
EOF
  }
}

resource kubernetes_secret user_data {
  metadata {
    name      = "kong-user-data"
    namespace = var.namespace
  }

  data = {
    "user-data" = <<EOF
        module.exports = ${jsonencode(local.user-default)}
EOF
  }
}

resource helm_release konga {
  name          = local.name
  atomic        = true
  repository    = var.chart_repository
  chart         = var.chart_name
  recreate_pods = var.recreate_pods
  namespace     = var.namespace
  set_sensitive {
    name  = "config.db_password"
    value = var.db_pass
  }
  set_sensitive {
    name  = "ldap.bind_pass"
    value = var.ldap_bind_pass
  }
  dynamic "set" {
    for_each = var.chart_extra_set_configs
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
  values = [
    yamlencode(
      {
        image = {
          repository  = var.konga_image
          tag         = var.konga_tag
          pullSecrets = var.reg_cred
        }
        config = {
          db_adapter      = "postgres"
          db_database     = var.db_name
          db_host         = var.db_host
          db_port         = var.db_port
          db_user         = var.db_user
          konga_node_data = "/etc/kong-data/kong-node.data"
          konga_user_data = "/etc/kong-user-data/kong-user.data"
          node_env        = "production"
          token_secret    = random_string.token_secret.result
        }
        ingress = {
          enabled     = var.enable_ingress
          annotations = var.ingress_annotations
          hosts = [
            {
              host  = var.ingress_host
              paths = [var.ingress_path]
            }
          ]
        }
        ldap = {
          auth_provider       = var.enable_ldap ? "ldap" : "local"
          host                = var.ldap_host
          bind_dn             = var.ldap_bind_dn
          user_search_base    = var.ldap_user_search_base
          user_search_filter  = var.ldap_user_search_filter
          user_attrs          = var.ldap_user_attrs
          group_search_base   = var.ldap_group_search_base
          group_search_filter = var.ldap_group_search_filter
          group_attrs         = var.ldap_group_attrs
          group_reg           = var.ldap_group_reg
          attr_username       = var.ldap_attr_username
          attr_firstname      = var.ldap_attr_firstname
          attr_lastname       = var.ldap_attr_lastname
          attr_email          = var.ldap_attr_email
        }
        extraVolumes = [
          {
            name = "node-data"
            secret = {
              secretName = kubernetes_secret.node_data.metadata.0.name
              items = [
                {
                  key  = "node-data"
                  path = "kong-node.data"
                }
              ]
            }
          },
          {
            name = "user-data"
            secret = {
              secretName = kubernetes_secret.user_data.metadata.0.name
              items = [
                {
                  key  = "user-data"
                  path = "kong-user.data"
                }
              ]
            }
          }
        ]
        extraVolumeMounts = [
          {
            name      = "node-data"
            mountPath = "/etc/kong-data"
          },
          {
            name      = "user-data"
            mountPath = "/etc/kong-user-data"
          }
        ]
        resources     = var.resources
        runMigrations = true
      }
    )
  ]
}