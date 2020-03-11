data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rsg_name
}

data "azurerm_log_analytics_workspace" "aks_oms" {
  name                = var.oms_name
  resource_group_name = var.oms_resource_group
}

#Create Azure Container Registry to be used by AKS

resource "azurerm_container_registry" "acr_prd" {
  name                = var.acr_name
  location            = azurerm_resource_group.aks_rsg.location
  resource_group_name = azurerm_resource_group.aks_rsg.name
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks_prd" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks_rsg.location
  resource_group_name = azurerm_resource_group.aks_rsg.name
  dns_prefix          = var.aks_dns
  kubernetes_version  = var.aks_version

  agent_pool_profile {
    name            = var.aks_agent_pool_name
    count           = var.aks_agent_number
    vm_size         = var.aks_agent_size
    os_type         = var.aks_agent_os
    os_disk_size_gb = var.aks_agent_disk_size
    vnet_subnet_id  = data.azurerm_subnet.aks_subnet.id
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_ip
    docker_bridge_cidr = var.aks_docker_bridge
    service_cidr       = var.aks_address_range
  }

  service_principal {
    client_id     = var.aks_spn_id
    client_secret = var.aks_spn_secret
  }

  role_based_access_control {
    enabled = false
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.aks_oms.id
    }
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks_prd.kube_config[0].client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_prd.kube_config_raw
}

