variable "associated" {
  type = map(object({
    subnet_name = string
    vnet_name   = string
    rg_name     = string
    table_name  = string
  }))
}
