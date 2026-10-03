variable "vm" {
  type = map(object({
    name           = string
    rg_name        = string
    kv_rg_name     = string
    key_vault_name = string
    secret_name    = string
    nic_name       = string
    vm_size        = string
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storage_os_disk = object({
      name              = string
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
    os_profile = object({
      computer_name  = string
      admin_username = string
    })
    os_profile_linux_config = object({
      disabled_password_authentication = bool
    })
  }))
}
