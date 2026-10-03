rg = {
  rg1 = {
    name     = "rg-axion-network-dev-cin"
    location = "centralindia"
  }
}
vnet = {
  hub = {
    name          = "vnet-axion-hub-dev-cin"
    rg_name       = "rg-axion-network-dev-cin"
    address_space = ["10.0.0.0/16"]
  }
  spoke_dev = {
    name          = "vnet-axion-spoke-dev-cin"
    rg_name       = "rg-axion-network-dev-cin"
    address_space = ["10.1.0.0/16"]
  }
  spoke_prod = {
    name          = "vnet-axion-spoke-prod-cin"
    rg_name       = "rg-axion-network-dev-cin"
    address_space = ["10.2.0.0/16"]
  }
}
subnet = {
  firewall = {
    name             = "AzureFirewallSubnet"
    vnet_name        = "vnet-axion-hub-dev-cin"
    rg_name          = "rg-axion-network-dev-cin"
    address_prefixes = ["10.0.1.0/26"]
  }
  firewall_management = {
    name             = "AzureFirewallManagementSubnet"
    vnet_name        = "vnet-axion-hub-dev-cin"
    rg_name          = "rg-axion-network-dev-cin"
    address_prefixes = ["10.0.2.0/26"]
  }
  shared_services = {
    name             = "snet-shared-services"
    vnet_name        = "vnet-axion-hub-dev-cin"
    rg_name          = "rg-axion-network-dev-cin"
    address_prefixes = ["10.0.3.0/24"]
  }
  dev_workload = {
    name             = "snet-workload-dev"
    vnet_name        = "vnet-axion-spoke-dev-cin"
    rg_name          = "rg-axion-network-dev-cin"
    address_prefixes = ["10.1.1.0/24"]
  }

  prod_workload = {
    name             = "snet-workload-prod"
    vnet_name        = "vnet-axion-spoke-prod-cin"
    rg_name          = "rg-axion-network-dev-cin"
    address_prefixes = ["10.2.1.0/24"]
  }
}
vnet_peer = {
  hub_to_dev = {
    name                    = "peer_hub_to_dev"
    local_vnet_name         = "vnet-axion-hub-dev-cin"
    remote_vnet_name        = "vnet-axion-spoke-dev-cin"
    remote_rg_name          = "rg-axion-network-dev-cin"
    rg_name                 = "rg-axion-network-dev-cin"
    allow_forwarded_traffic = true

  }
  dev_to_hub = {
    name                    = "peer_dev_to_hub"
    local_vnet_name         = "vnet-axion-spoke-dev-cin"
    remote_vnet_name        = "vnet-axion-hub-dev-cin"
    remote_rg_name          = "rg-axion-network-dev-cin"
    rg_name                 = "rg-axion-network-dev-cin"
    allow_forwarded_traffic = true

  }
  hub_to_prod = {
    name                         = "peer-hub-to-prod"
    local_vnet_name              = "vnet-axion-hub-dev-cin"
    rg_name                      = "rg-axion-network-dev-cin"
    remote_rg_name               = "rg-axion-network-dev-cin"
    remote_vnet_name             = "vnet-axion-spoke-prod-cin"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
  }

  prod_to_hub = {
    name                         = "peer-prod-to-hub"
    local_vnet_name              = "vnet-axion-spoke-prod-cin"
    rg_name                      = "rg-axion-network-dev-cin"
    remote_rg_name               = "rg-axion-network-dev-cin"
    remote_vnet_name             = "vnet-axion-hub-dev-cin"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
  }
}
firewall = {
  hub_firewall = {
    name           = "afw-axion-hub-dev-cin"
    rg_name        = "rg-axion-network-dev-cin"
    sku_name       = "AZFW_VNet"
    sku_tier       = "Basic"
    vnet_name      = "vnet-axion-hub-dev-cin"
    subnet_name    = "AzureFirewallSubnet"
    public_ip_name = "pip-afw-axion-dev-cin"

    ip_configuration = {
      name = "afw-ipconfig"
    }
    management_ip_configuration = {
      name = "afw-mgmt-ipconfig"
    }
  }
}
pip = {
  pip1 = {
    name              = "pip-afw-axion-dev-cin"
    rg_name           = "rg-axion-network-dev-cin"
    allocation_method = "Static"
  }
  pip2 = {
    name              = "pip-afw-mgmt-axion-dev-cin"
    rg_name           = "rg-axion-network-dev-cin"
    allocation_method = "Static"
  }
}
nic = {
  dev_vm_nic = {
    name        = "nic-axion-dev-01"
    rg_name     = "rg-axion-network-dev-cin"
    subnet_name = "snet-workload-dev"
    vnet_name   = "vnet-axion-spoke-dev-cin"

    ip_configuration = {
      ipconfig1 = {
        name                          = "ipconfig-dev"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }

  prod_vm_nic = {
    name        = "nic-axion-prod-01"
    rg_name     = "rg-axion-network-dev-cin"
    subnet_name = "snet-workload-prod"
    vnet_name   = "vnet-axion-spoke-prod-cin"

    ip_configuration = {
      ipconfig1 = {
        name                          = "ipconfig-prod"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}
nsg = {
  dev_nsg = {
    name    = "nsg-axion-spoke-dev-cin"
    rg_name = "rg-axion-network-dev-cin"

    security_rule = {
      allow_icmp_from_prod = {
        name                       = "Allow-ICMP-From-Prod"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Icmp"
        source_address_prefix      = "10.2.0.0/16"
        destination_address_prefix = "10.1.0.0/16"
        source_port_range          = "*"
        destination_port_range     = "*"
      }
    }
  }

  prod_nsg = {
    name    = "nsg-axion-spoke-prod-cin"
    rg_name = "rg-axion-network-dev-cin"

    security_rule = {
      allow_icmp_from_dev = {
        name                       = "Allow-ICMP-From-Dev"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Icmp"
        source_address_prefix      = "10.1.0.0/16"
        destination_address_prefix = "10.2.0.0/16"
        source_port_range          = "*"
        destination_port_range     = "*"
      }
    }
  }
}
associate = {
  dev_nsg_association = {
    nsg_name    = "nsg-axion-spoke-dev-cin"
    rg_name     = "rg-axion-network-dev-cin"
    subnet_name = "snet-workload-dev"
    vnet_name   = "vnet-axion-spoke-dev-cin"
  }

  prod_nsg_association = {
    nsg_name    = "nsg-axion-spoke-prod-cin"
    rg_name     = "rg-axion-network-dev-cin"
    subnet_name = "snet-workload-prod"
    vnet_name   = "vnet-axion-spoke-prod-cin"
  }
}
udr = {
  dev_udr = {
    name    = "rt-axion-spoke-dev-cin"
    rg_name = "rg-axion-network-dev-cin"

    route = [
      {
        name           = "route-to-prod-via-firewall"
        address_prefix = "10.2.0.0/16"
        next_hop_type  = "VirtualAppliance"
      }
    ]
  }

  prod_udr = {
    name    = "rt-axion-spoke-prod-cin"
    rg_name = "rg-axion-network-dev-cin"

    route = [
      {
        name           = "route-to-dev-via-firewall"
        address_prefix = "10.1.0.0/16"
        next_hop_type  = "VirtualAppliance"
      }
    ]
  }
}
vm = {
  vm1 = {
    name     = "vm-axion-dev-01"
    rg_name  = "rg-axion-network-dev-cin"
    nic_name = "nic-axion-dev-01"
    vm_size  = "Standard_D2als_v6"

    # Key Vault - unchanged
    kv_rg_name     = "mono-dev-shared-rg"
    key_vault_name = "mono-shared-kv"
    secret_name    = "mono-frontend-dev-vm-secret"

    storage_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }

    storage_os_disk = {
      name              = "osdisk-axion-dev-01"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }

    os_profile = {
      computer_name  = "vm-axion-dev-01"
      admin_username = "devvm1"
    }

    os_profile_linux_config = {
      disabled_password_authentication = false
    }
  }

  vm2 = {
    name     = "vm-axion-prod-01"
    rg_name  = "rg-axion-network-dev-cin"
    nic_name = "nic-axion-prod-01"
    vm_size  = "Standard_D2als_v6"

    # Key Vault - unchanged
    kv_rg_name     = "mono-dev-shared-rg"
    key_vault_name = "mono-shared-kv"
    secret_name    = "mono-backend-dev-vm-secret"

    storage_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }

    storage_os_disk = {
      name              = "osdisk-axion-prod-01"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }

    os_profile = {
      computer_name  = "vm-axion-prod-01"
      admin_username = "prodvm1"
    }

    os_profile_linux_config = {
      disabled_password_authentication = false
    }
  }
}
associated = {
  dev_route_table_association = {
    subnet_name = "snet-workload-dev"
    vnet_name   = "vnet-axion-spoke-dev-cin"
    rg_name     = "rg-axion-network-dev-cin"
    table_name  = "rt-axion-spoke-dev-cin"
  }

  prod_route_table_association = {
    subnet_name = "snet-workload-prod"
    vnet_name   = "vnet-axion-spoke-prod-cin"
    rg_name     = "rg-axion-network-dev-cin"
    table_name  = "rt-axion-spoke-prod-cin"
  }
}
firewall_policy = {
  hub_policy = {
    name    = "afwp-axion-hub-dev-cin"
    rg_name = "rg-axion-network-dev-cin"
    sku = "Basic"
  }
}
rule_collection = {
  hub_network_rules = {
    name     = "rcg-axion-hub-dev-cin"
    priority = 100

    network_rule_collection = {
      spoke_to_spoke = {
        name     = "nrc-allow-spoke-to-spoke"
        priority = 100
        action   = "Allow"

        rule = {
          dev_to_prod = {
            name                  = "allow-dev-to-prod-icmp"
            protocols             = ["ICMP"]
            source_addresses      = ["10.1.0.0/16"]
            destination_addresses = ["10.2.0.0/16"]
            destination_ports     = ["*"]
          }

          prod_to_dev = {
            name                  = "allow-prod-to-dev-icmp"
            protocols             = ["ICMP"]
            source_addresses      = ["10.2.0.0/16"]
            destination_addresses = ["10.1.0.0/16"]
            destination_ports     = ["*"]
          }
        }
      }
    }
  }
}
