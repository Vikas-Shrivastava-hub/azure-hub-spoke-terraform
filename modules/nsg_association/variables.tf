variable "associate" {
    type = map(object({
        nsg_name = string
        rg_name = string
        subnet_name = string
        vnet_name = string
    }))
}