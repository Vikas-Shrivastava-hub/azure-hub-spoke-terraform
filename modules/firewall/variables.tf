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
variable "manage_subnet_id" {
  type    = string
  default = null

}
variable "manage_public_ip_id" {
  type    = string
  default = null

}
variable "ip_subnet_id" {
  type    = string
  default = null

}
variable "ip_public_ip_address_id" {
  type    = string
  default = null

}
variable "firewall_policy_id" {
  type    = string
  default = null

}
