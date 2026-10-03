variable "subnet" {
  type = map(object({
    name             = string
    vnet_name        = string
    rg_name          = string
    address_prefixes = list(string)
    delegation = optional(object({
      name = string
      service_delegation = object({
        name   = string
        action = optional(list(string))

      })
    }))
    default_outbound_access_enabled = optional(bool)
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = number
    }))
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoint_policy_ids                   = optional(list(string))

  }))
}
