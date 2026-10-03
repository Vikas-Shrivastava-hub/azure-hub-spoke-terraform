output "pip_id" {
    value = { for keys, pip in azurerm_public_ip.public_ip : keys => pip.id}
}