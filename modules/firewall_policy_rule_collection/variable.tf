variable "rule_collection" {
  type = map(object({
    name     = string
    priority = number

    application_rule_collection = optional(map(object({
      name     = string
      priority = number
      action   = string

      rule = map(object({
        name                  = string
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        terminate_tls         = optional(bool)

        protocols = list(object({
          type = string
          port = number
        }))
      }))
    })))

    network_rule_collection = optional(map(object({
      name     = string
      priority = number
      action   = string

      rule = map(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_ports     = list(string)
      }))
    })))

    nat_rule_collection = optional(map(object({
      name     = string
      priority = number
      action   = string

      rule = map(object({
        name                = string
        protocols           = list(string)
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        destination_address = string
        destination_ports   = list(string)
        translated_address  = optional(string)
        translated_fqdn     = optional(string)
        translated_port     = string
      }))
    })))
  }))
}

variable "firewall_policy_id" {
  type = string
}
