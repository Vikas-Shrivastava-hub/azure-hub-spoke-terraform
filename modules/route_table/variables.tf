variable "udr" {
    type = map(object({
        name = string
        rg_name = string
        route = optional(list(object({
            name = string
            address_prefix = string
            next_hop_type = string
            next_hop_in_ip_address = optional(string)
        })))
        bgp_route_propagation_enabled = optional(bool)
    }))
}
variable "next_hop_in_ip_address" {
    type = string
    default = null
}