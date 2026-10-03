module "rg" {
  source = "../../modules/resource_group"
  rg     = var.rg
}

module "vnet" {
  depends_on = [module.rg]

  source = "../../modules/virtual_network"
  vnet   = var.vnet
}

module "subnet" {
  depends_on = [module.vnet]

  source = "../../modules/subnet"
  subnet = var.subnet
}

module "vnet_peering" {
  depends_on = [module.vnet]

  source    = "../../modules/vnet_peering"
  vnet_peer = var.vnet_peer
}

module "pip" {
  depends_on = [module.rg]

  source = "../../modules/public_ip"
  pip    = var.pip
}

module "firewall_policy" {
  depends_on = [module.rg]

  source          = "../../modules/firewall_policy"
  firewall_policy = var.firewall_policy
}

module "firewall" {
  depends_on = [module.firewall_policy]
  source     = "../../modules/firewall"
  firewall   = var.firewall

  ip_subnet_id            = module.subnet.subnet_id["firewall"]
  ip_public_ip_address_id = module.pip.pip_id["pip1"]

  manage_subnet_id    = module.subnet.subnet_id["firewall_management"]
  manage_public_ip_id = module.pip.pip_id["pip2"]

  firewall_policy_id = module.firewall_policy.policy_id["hub_policy"]
}

module "nic" {
  depends_on = [module.subnet]

  source = "../../modules/nic"
  nic    = var.nic
}

module "nsg" {
  depends_on = [module.rg]

  source = "../../modules/nsg"
  nsg    = var.nsg
}

module "nsg_associate" {
  depends_on = [
    module.subnet,
    module.nsg
  ]

  source    = "../../modules/nsg_association"
  associate = var.associate
}

module "route_table" {
  depends_on = [module.rg]
  source     = "../../modules/route_table"
  udr        = var.udr

  next_hop_in_ip_address = module.firewall.firewall_private_ip["hub_firewall"]
}

module "route_association" {
  depends_on = [
    module.subnet,
    module.route_table
  ]

  source     = "../../modules/route_table_association"
  associated = var.associated
}

module "vm" {
  depends_on = [module.nic]

  source = "../../modules/virtual_machine"
  vm     = var.vm
}
module "rule_collection" {
  depends_on         = [module.firewall_policy]
  source             = "../../modules/firewall_policy_rule_collection"
  rule_collection    = var.rule_collection
  firewall_policy_id = module.firewall_policy.policy_id["hub_policy"]

}