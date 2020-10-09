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
  default     = ""
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

variable kong_name {
  description = "Kong name connection"
  type        = string
  default     = "kong"
}

variable kong_url {
  description = "Kong URI connection"
  type        = string
  default     = "http://admin.local:8001"

  validation {
    condition     = can(regex("^https?://.+:\\d+", var.kong_url))
    error_message = "URI for LDAP begin with http[s]://hostname:port ."
  }
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

variable enable_ldap {
  description = "Enable LDAP connection for Konga"
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
  description = "BIND DN to konga should use to login to LDAP to search users"
  type        = string
  default     = "cn=konga,ou=admin,dc=example,dc=com"
}

variable ldap_bind_pass {
  description = "BIND PASS for the user konga will use to search for users"
  type        = string
  default     = "secret"
}

variable ldap_user_search_base {
  description = "Base DN used to search for users"
  type        = string
  default     = "ou=users,dc=com"
}

variable ldap_user_search_filter {
  description = "The filter expression used to search for users"
  type        = string
  default     = "sAMAccountName={{username}}"
}

variable ldap_user_attrs {
  description = "List of attributes to pull from the LDAP server for users"
  type        = string
  default     = "sAMAccountName,uSNCreated,givenName,sn,mail"
}

variable ldap_group_search_base {
  description = "Base DN used to search for groups"
  type        = string
  default     = "ou=groups,dc=com"
}

variable ldap_group_search_filter {
  description = "Filter expression used to search for groups"
  type        = string
  default     = "(|(memberUid={{uid}})(memberUid={{uidNumber}})(sAMAccountName={{uid}}))"
}

variable ldap_group_attrs {
  description = "List of attributes to pull from the LDAP server for groups"
  type        = string
  default     = "cn"
}

variable ldap_group_reg {
  description = "Regular expression used to determine if a group should be considered as an admin user"
  type        = string
  default     = "^(admin|konga)$"
}

variable ldap_attr_username {
  description = "LDAP attribute name that should be used as the konga username"
  type        = string
  default     = "sAMAccountName"
}

variable ldap_attr_firstname {
  description = "LDAP attribute name that should be used as the konga user's first name"
  type        = string
  default     = "givenName"
}

variable ldap_attr_lastname {
  description = "LDAP attribute name that should be used as the konga user's last name"
  type        = string
  default     = "sn"
}

variable ldap_attr_email {
  description = "LDAP attribute name that should be used as the konga user's email address"
  type        = string
  default     = "mail"
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

variable cpu_limit {
  description = "Cpu limit for pods in Konga deployment"
  type        = string
  default     = "600m"

  validation {
    condition     = regex("^\\d+", var.cpu_limit) >= 600
    error_message = "Minimum CPU limit should be 600m for Konga in Development environment."
  }
}

variable cpu_request {
  description = "Cpu request for pods in Konga deployment"
  type        = string
  default     = "250m"

  validation {
    condition     = regex("^\\d+", var.cpu_request) >= 250
    error_message = "Minimum CPU request should be 250m for Konga in Development environment."
  }
}

variable memory_limit {
  description = "Memory limit for pods in Konga deployment"
  type        = string
  default     = "400Mi"

  validation {
    condition     = regex("^\\d+", var.memory_limit) >= 400
    error_message = "Minimum memory limit should be 400Mi for Konga in Development environment."
  }
}

variable memory_request {
  description = "Memory request for pods in Konga deployment"
  type        = string
  default     = "180Mi"

  validation {
    condition     = regex("^\\d+", var.memory_request) >= 180
    error_message = "Minimum memory request should be 180Mi for Konga in Development environment."
  }
}