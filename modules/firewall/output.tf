output "firewall_private_ip" {
  value = { for keys, firewall in azurerm_firewall.firewall : keys => firewall.ip_configuration[0].private_ip_address }

}
