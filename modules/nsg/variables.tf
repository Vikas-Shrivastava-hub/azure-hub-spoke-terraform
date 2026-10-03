variable "nsg" {
  type = map(object({
    name    = string
    rg_name = string
    security_rule = optional(map(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_address_prefix        = string
      destination_address_prefix   = string
      source_port_range            = string
      destination_port_range       = string
      source_port_ranges           = optional(list(string))
      destination_port_ranges      = optional(list(string))
      destination_address_prefixes = optional(list(string))
      source_address_prefixes      = optional(list(string))


    })))
  }))
}
