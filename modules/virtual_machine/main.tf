resource "azurerm_virtual_machine" "vm" {
  for_each              = var.vm
  name                  = each.value.name
  resource_group_name   = data.azurerm_resource_group.rg[each.key].name
  location              = data.azurerm_resource_group.rg[each.key].location
  vm_size               = each.value.vm_size
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  storage_image_reference {
    publisher = each.value.storage_image_reference.publisher
    offer     = each.value.storage_image_reference.offer
    sku       = each.value.storage_image_reference.sku
    version   = each.value.storage_image_reference.version
  }
  storage_os_disk {
    name              = each.value.storage_os_disk.name
    caching           = each.value.storage_os_disk.caching
    create_option     = each.value.storage_os_disk.create_option
    managed_disk_type = each.value.storage_os_disk.managed_disk_type
  }
  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = each.value.os_profile.admin_username
    admin_password = data.azurerm_key_vault_secret.kv_secret[each.key].value
  }
  os_profile_linux_config {
    disable_password_authentication = each.value.os_profile_linux_config.disabled_password_authentication
  }


}
