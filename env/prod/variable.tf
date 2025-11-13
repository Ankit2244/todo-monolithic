variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)

  }))
}


variable "vnets" {
  description = "Map of VNets and their subnet configurations."
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    address_space           = list(string)
    dns_servers             = optional(list(string))
    bgp_community           = optional(string)
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))

    ddos_protection_plan = optional(object({
      id     = string
      enable = optional(bool, true)
    }))

    subnets = optional(list(object({
      name                                           = string
      address_prefixes                               = list(string)
      private_endpoint_network_policies_enabled      = optional(bool)
      private_link_service_network_policies_enabled  = optional(bool)
      service_endpoints                              = optional(list(string))
      service_endpoint_policy_ids                    = optional(list(string))
      enforce_private_link_endpoint_network_policies = optional(bool)
      delegations = optional(list(object({
        name  = string
        service_delegation = object({
          name    = string
          actions = list(string)
        })
      })))
    })))
  }))
}


variable "container_registery" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool
  }))
}

# variable "key_vault" {
#   type = map(object({
#     name                        = string
#     location                    = string
#     resource_group_name         = string
#     enabled_for_disk_encryption = bool
#     tenant_id                   = string
#     soft_delete_retention_days  = number
#     purge_protection_enabled    = bool
#     sku_name                    = string
#     access_policy               = map(string)
#   }))
# }

variable "key_vault" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = string
    tenant_id                   = string
    soft_delete_retention_days  = string
    purge_protection_enabled    = string
    sku_name                    = string

    access_policy = list(object({
      tenant_id = string
      object_id = string

      key_permissions    = list(string)
      secret_permissions = list(string)
      storage_permissions = list(string)
    }))
  }))
}

variable "sql_servers" {
  description = "Map of SQL servers to create"
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    version               = optional(string)
    admin_username        = string
    admin_password        = string
    minimum_tls_version   = optional(string)
    environment           = optional(string)
    owner                 = optional(string)
    tags                  = optional(map(string))
  }))
}


variable "sql_db_name" {
  description = "Map of MSSQL Databases to create"
  type = map(object({
    name         = string
    server_id    = string
    collation    = optional(string)
    license_type = optional(string)
    max_size_gb  = optional(number)
    sku_name     = optional(string)
    enclave_type = optional(string)
    depends_on   = optional(list(any))  # for optional dependency injection
  }))
}





variable "pip" {
  description = "Map of Public IP configurations"
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    allocation_method       = optional(string)
    sku                     = optional(string)
    ip_version              = optional(string)
    idle_timeout_in_minutes = optional(number)
    zones                   = optional(list(string))
    environment             = optional(string)
    dns_settings = optional(object({
      domain_name_label = optional(string)
      reverse_fqdn      = optional(string)
    }))
    tags = optional(map(string))
  }))
}

variable "nsg" {
  type = map(object({
    name                = string
    location            = optional(string)
    resource_group_name = optional(string)
    tags                = optional(map(string))
    security_rule = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      description                = optional(string)
    })))
  }))
}


variable "vms" {
  type = map(object({
    nic_name               = string
    location               = string
    resource_group_name    = string
    virtual_network_name   = string
    subnet_name            = string
    pip_name               = string
    vm_name                = string
    size                   = string
    admin_username         = string
    admin_password         = string
    source_image_reference = map(string)

  }))
}
