## KONGA MODULE
This repo bring to use Konga as manager for ours Kong API Gateways.

### Konga
An open source tool that enables you to manage your Kong API Gateway with ease

### Requirements
| Name | Version |
|:----:|:-------:|
| Terraform | `>= 0.13` |
| Kubernetes | `>= 1.16` |
| PostgreSQL | `>= 9.5` |
| LDAP(optional) | `""` |

### Components
Previously we used a copy of the full panzel chart in this module and update it locally, now we will use our chart with those modifications.

We decide going to use our chart by default because they have the changes we need to be able to directly integrate an adapter for postgres or mysql.

These changes have already been requested to be accepted in the official konga chart https://github.com/pantsel/konga/pull/622

| Name | Repository | Version |
|:----:|:----------:|:-------:|
| Konga Chart | https://charts.bennu.cl | `>= 1.0.2` |


#### Example main.tf
```hcl
module "konga" {
  source  = "bennu/konga/helm"
  version = "0.0.8"

  db_host   = var.db_host
  db_name   = var.db_name
  db_pass   = var.db_pass
  db_user   = var.db_user
  namespace = "default"

  user_data = {
    "username"  = "xyz_admin",
    "email"     = "myadmin@some.domain",
    "firstName" = "xyz",
    "lastName"  = "domain",
  }
}
```
```hcl
module "konga-prod" {
  source  = "bennu/konga/helm"

  db_host   = var.db_host
  db_name   = var.db_name
  db_pass   = var.db_pass
  db_user   = var.db_user
  namespace = "api-management"

  user_data = {
    "username"  = "management",
  }

  # It is possible to set a definition about the resources pods, so you only need to declare it.
  # using "resources" variable to map the limits as you need.
  resources = {
    requests = {
      memory = "150Mi"
      cpu    = "175m"
    }
    limits = {
      memory = "500Mi"
      cpu    = "650m"
    }
  }
}
```

### Module Variables
Some details about variables for this Kong module.

#### Inputs
| Name | Description | Type | Default | Required |
|:----:|:-----------:|:----:|:-------:|:--------:|
| chart_name | Helm chart name for Konga | `string` | `"konga"` | no |
| chart_repository | Helm chart repository for Konga | `string` | `"https://charts.bennu.cl"` | no |
| chart_extra_set_configs | Using a list of maps as `[{"name"="foo", "value"="bar"},]` to create dynamics blocks of 'set' to merge with values | `list` | `[]` | no |
| db_host | PostgreSQL database hostname | `string` | n/a | yes |
| db_name | PostgreSQL database name | `string` | n/a | yes |
| db_pass | PostgreSQL database password | `string` | n/a | yes |
| db_port | PostgreSQL database port | `string` | `"5432"` | no |
| db_user | PostgreSQL database user | `string` | n/a | yes |
| enable_ingress | Enable ingress for Konga | `bool` | `false` | no |
| enable_ldap | Enable LDAP connection for Konga | `bool` | `false` | no |
| ingress_annotations | Ingress annotations for Konga | `map` | `{}` | no |
| ingress_host | Ingress host for Konga | `string` | `"konga.local"` | no |
| ingress_path | Ingress path for Konga | `string` | `"/"` | no |
| kong_name | Kong name connection | `string` | `"kong"` | no |
| kong_url | Kong URI connection | `string` | `"http://admin.local:8001"` | no |
| konga_image | Docker image for Konga | `string` | `"pantsel/konga"` | no |
| konga_tag | Docker tag image for Konga | `string` | `"0.14.9"` | no |
| ldap_attr_email | LDAP attribute name that should be used as the konga user's email address | `string` | `"mail"` | no |
| ldap_attr_firstname | LDAP attribute name that should be used as the konga user's first name | `string` | `"givenName"` | no |
| ldap_attr_lastname | LDAP attribute name that should be used as the konga user's last name | `string` | `"sn"` | no |
| ldap_attr_username | LDAP attribute name that should be used as the konga username | `string` | `"sAMAccountName"` | no |
| ldap_bind_dn | BIND DN to konga should use to login to LDAP to search users | `string` | `"cn=konga,ou=admin,dc=example,dc=com"` | no |
| ldap_bind_pass | BIND PASS for the user konga will use to search for users | `string` | `"secret"` | no |
| ldap_group_attrs | List of attributes to pull from the LDAP server for groups | `string` | `"cn"` | no |
| ldap_group_reg | Regular expression used to determine if a group should be considered as an admin user | `string` | `"^(admin\|konga)$"` | no |
| ldap_group_search_base | Base DN used to search for groups | `string` | `"ou=groups,dc=com"` | no |
| ldap_group_search_filter | Filter expression used to search for groups | `string` | `"(\|(memberUid={{uid}})(memberUid={{uidNumber}})(sAMAccountName={{uid}}))"` | no |
| ldap_host | LDAP Server connection as ldap:// | `string` | `"ldap://localhost:389"` | no |
| ldap_user_attrs | List of attributes to pull from the LDAP server for users | `string` | `"sAMAccountName,uSNCreated,givenName,sn,mail"` | no |
| ldap_user_search_base | Base DN used to search for users | `string` | `"ou=users,dc=com"` | no |
| ldap_user_search_filter | The filter expression used to search for users | `string` | `"sAMAccountName={{username}}"` | no |
| name | Value for konga name in pods | `string` | `""` | no |
| namespace | Namespace where resources are deployed | `string` | `"default"` | no |
| recreate_pods | Used for restart pods when some changes in configmap are doing for Konga | `bool` | `true` | no |
| resources | Define the limits and/or requests on pod resources | `map` | `{}` | no |
| user_data | User default data information used to autoconfigure when run Konga | `map` | <pre>{<br>  "email": "devops@mail.com",<br>  "firstName": "Admin",<br>  "lastName": "Konga",<br>  "username": "devops"<br>}</pre> | no |

## Outputs
| Name | Description |
|:----:|:-----------:|
| hostname | Konga hostname |
| password | Password for default user, valid when LDAP is disable |
