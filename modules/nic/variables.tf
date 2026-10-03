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
