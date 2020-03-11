# See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html for Syntax.

resource "azurerm_redis_cache" "redis" {
  name                = "hcwdb01"
  resource_group_name = azurerm_resource_group.paas_rsg.name
  location            = azurerm_resource_group.paas_rsg.location
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false

  redis_configuration {
    maxmemory_reserved = 50
    maxmemory_delta    = 50
    maxmemory_policy   = "volatile-lru"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

