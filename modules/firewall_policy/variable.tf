variable "firewall_policy" {
  type = map(object({
    name    = string
    rg_name = string
    sku     = string
  }))

}
