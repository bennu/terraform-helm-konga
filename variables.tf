variable name {
  description = "Value for konga name in pods"
  type        = string
  default     = ""
}

variable namespace {
  description = "Namespace where resources are deployed"
  type        = string
  default     = "default"
}

variable recreate_pods {
  description = "Used for restart pods when some changes in configmap are doing for Konga"
  type        = bool
  default     = true
}

variable chart_repository {
  description = "Helm chart repository for Konga"
  type        = string
  default     = "https://charts.bennu.cl"
}

variable chart_name {
  description = "Helm chart name for Konga"
  type        = string
  default     = "konga"
}

variable chart_extra_set_configs {
  description = "Using a list of maps as `[{\"name\"=\"foo\", \"value\"=\"bar\"},]` to create dynamics blocks of 'set' to merge with values"
  type        = list
  default     = []
}

variable db_host {
  description = "PostgreSQL database hostname"
  type        = string
}

variable db_port {
  description = "PostgreSQL database port"
  type        = string
  default     = "5432"
}

variable db_name {
  description = "PostgreSQL database name"
  type        = string
}

variable db_pass {
  description = "PostgreSQL database password"
  type        = string
}

variable db_user {
  description = "PostgreSQL database user"
  type        = string
}

variable ingress_annotations {
  description = "Ingress annotations for Konga"
  type        = map
  default     = {}
}

variable enable_ingress {
  description = "Enable ingress for Konga"
  type        = bool
  default     = false
}

variable ingress_host {
  description = "Ingress host for Konga"
  type        = string
  default     = "konga.local"
}

variable ingress_path {
  description = "Ingress path for Konga"
  type        = string
  default     = "/"
}

variable kong_endpoints {
  description = "List of Kong endpoints connections used in Konga UI, Example: `[{\"kong_admin_url\"=\"http://admin.local:8001\", \"name\"=\"kong-admin\", \"type\"=\"default\"},]`"
  type        = list
  default     = []
}

variable konga_image {
  description = "Docker image for Konga"
  type        = string
  default     = "pantsel/konga"
}

variable konga_tag {
  description = "Docker tag image for Konga"
  type        = string
  default     = "0.14.9"
}

variable reg_cred {
  description = "Registry secret credential"
  type        = list
  default     = []
}

variable enable_ldap {
  description = "Enable LDAP connection for Konga. We can use configuration defined on https://github.com/pantsel/konga/blob/master/docs/LDAP.md if enable LDAP"
  type        = bool
  default     = false
}

variable ldap_host {
  description = "LDAP Server connection as ldap://"
  type        = string
  default     = "ldap://localhost:389"

  validation {
    condition     = can(regex("^ldap://.+", var.ldap_host))
    error_message = "URI LDAP server begin with ldap:// ."
  }
}

variable ldap_bind_dn {
  description = "BIND DN to konga should use to login to LDAP to search users. Example: `\"cn=konga,ou=admin,dc=example,dc=com\"`"
  type        = string
  default     = "dc=example,dc=com"
}

variable ldap_bind_pass {
  description = "BIND PASS for the user konga will use to search for users"
  type        = string
  default     = "secret"
}

variable ldap_user_search_base {
  description = "Base DN used to search for users. Example: `\"ou=users,dc=com\"`"
  type        = string
  default     = null
}

variable ldap_user_search_filter {
  description = "The filter expression used to search for users. Example: `\"sAMAccountName={{username}}\"`"
  type        = string
  default     = null
}

variable ldap_user_attrs {
  description = "List of attributes to pull from the LDAP server for users. Example: `\"sAMAccountName,uSNCreated,givenName,sn,mail\"`"
  type        = string
  default     = null
}

variable ldap_group_search_base {
  description = "Base DN used to search for groups. Example: `\"ou=groups,dc=com\"`"
  type        = string
  default     = null
}

variable ldap_group_search_filter {
  description = "Filter expression used to search for groups. Example: `\"(|(memberUid={{uid}})(memberUid={{uidNumber}})(sAMAccountName={{uid}}))\"`"
  type        = string
  default     = null
}

variable ldap_group_attrs {
  description = "List of attributes to pull from the LDAP server for groups. Example: `\"cn\"`"
  type        = string
  default     = null
}

variable ldap_group_reg {
  description = "Regular expression used to determine if a group should be considered as an admin user. Example: `\"^(admin|konga)$ \"`"
  type        = string
  default     = null
}

variable ldap_attr_username {
  description = "LDAP attribute name that should be used as the konga username. Example: `\"sAMAccountName\"`"
  type        = string
  default     = null
}

variable ldap_attr_firstname {
  description = "LDAP attribute name that should be used as the konga user's first name. Example: `\"givenName\"`"
  type        = string
  default     = null
}

variable ldap_attr_lastname {
  description = "LDAP attribute name that should be used as the konga user's last name. Example: `\"sn\"`"
  type        = string
  default     = null
}

variable ldap_attr_email {
  description = "LDAP attribute name that should be used as the konga user's email address. Example: `\"mail\"`"
  type        = string
  default     = null
}

variable user_data {
  description = "User default data information used to autoconfigure when run Konga"
  type        = map
  default = {
    "username" : "devops",
    "email" : "devops@mail.com",
    "firstName" : "Admin",
    "lastName" : "Konga",
  }
}

variable resources {
  description = "Define the limits and/or requests on pod resources"
  type        = map
  default     = {}
}