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
