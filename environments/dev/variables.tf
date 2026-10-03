variable "rg" {
  type = map(object({
    name     = string
    location = string
  }))
}
variable "vnet" {
  type = map(object({
    name          = string
    rg_name       = string
    address_space = list(string)
  }))
}
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
variable "vnet_peer" {
  type = map(object({
    name                                   = string
    local_vnet_name                        = string
    remote_vnet_name                       = string
    remote_rg_name                         = string
    rg_name                                = string
    allow_virtual_network_access           = optional(bool)
    allow_forwarded_traffic                = optional(bool)
    allow_gateway_transit                  = optional(bool)
    local_subnet_names                     = optional(list(string))
    only_ipv6_peering_enabled              = optional(bool)
    peer_complete_virtual_networks_enabled = optional(bool)
    remote_subnet_names                    = optional(list(string))
    use_remote_gateways                    = optional(bool)
  }))
}
variable "firewall" {
  type = map(object({
    name               = string
    rg_name            = string
    sku_name           = string
    sku_tier           = string
    vnet_name          = string
    subnet_name        = string
    public_ip_name     = string
    firewall_policy_id = optional(string)

    ip_configuration = optional(object({
      name = string
    }))

    dns_servers       = optional(list(string))
    dns_proxy_enabled = optional(bool)
    private_ip_ranges = optional(list(string))

    management_ip_configuration = optional(object({
      name = string
    }))

    threat_intel_mode = optional(string)

    virtual_hub = optional(object({
      public_ip_count = optional(number)
    }))

    zones = optional(list(string))
  }))
}



variable "pip" {
  type = map(object({
    name                    = string
    rg_name                 = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
    ip_tags                 = optional(map(string))
  }))
}
variable "nic" {
  type = map(object({
    name        = string
    rg_name     = string
    subnet_name = string
    vnet_name   = string
    ip_configuration = map(object({
      name                                               = string
      private_ip_address_allocation                      = string
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
    }))
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_server                     = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
  }))
}
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
variable "associate" {
  type = map(object({
    nsg_name    = string
    rg_name     = string
    subnet_name = string
    vnet_name   = string
  }))
}
variable "udr" {
  type = map(object({
    name    = string
    rg_name = string
    route = optional(list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })))
    bgp_route_propagation_enabled = optional(bool)
  }))
}
variable "vm" {
  type = map(object({
    name           = string
    rg_name        = string
    kv_rg_name     = string
    key_vault_name = string
    secret_name    = string
    nic_name       = string
    vm_size        = string
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storage_os_disk = object({
      name              = string
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
    os_profile = object({
      computer_name  = string
      admin_username = string
    })
    os_profile_linux_config = object({
      disabled_password_authentication = bool
    })
  }))
}
variable "associated" {
  type = map(object({
    subnet_name = string
    vnet_name   = string
    rg_name     = string
    table_name  = string
  }))
}
variable "firewall_policy" {
  type = map(object({
    name    = string
    rg_name = string
    sku     = string
  }))

}
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








