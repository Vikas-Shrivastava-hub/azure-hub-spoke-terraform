variable "vnet" {
  type = map(object({
    name          = string
    rg_name       = string
    address_space = list(string)
  }))
}
