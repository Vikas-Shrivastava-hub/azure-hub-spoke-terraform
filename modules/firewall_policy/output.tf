output "policy_id" {
    value = { for keys, policy in azurerm_firewall_policy.policy : keys => policy.id}
  
}