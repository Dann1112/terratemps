# Creates an App Service Plan
module "app_plan" {
  source      = ".//appServicePlan"
  buildby     = "Racker"
  buildticket = "Build Ticket"
  environment = "Production"
  location    = "East US 2"
  asp_name    = "LOC-ENV-PLAN01"
  rsg         = "module"
  kind        = "Windows"
  tier        = "Standard"
  size        = "S1"
  capacity    = 1
}

# Creates an App Service
module "app_service" {
  source      = ".//appService"
  buildby     = "Racker"
  buildticket = "Build Ticket"
  environment = "Production"
  location    = "East US 2"
  asp_name    = "${module.app_plan.app_plan_name}"
  asp_rsg     = "${module.app_plan.app_plan_rsg}"
  app_name    = "modueltestingadawd"
  rsg         = "module"
  https       = false
  dotnet      = "v4.0"
  always_on   = false
}

# Creates a SQL Server
module "sql_server" {
  source         = ".//sqlServer"
  buildby        = "Racker"
  buildticket    = "Build Ticket"
  environment    = "Production"
  location       = "East US 2"
  rsg            = "module"
  name           = "moduleasdhasddaasdh"
  ver            = "12.0"
  admin_name     = "happy_pants"
  admin_password = "MEA7ZybLt6yN4KTA"
}

# Creates a SQL database that is not in an elastic pool
module "sql_database" {
  source      = ".//sqlDatabase"
  buildby     = "Racker"
  buildticket = "Build Ticket"
  environment = "Production"
  location    = "East US 2"
  server_name = "${module.sql_server.sql_server_name}"
  server_rsg  = "${module.sql_server.sql_server_rsg}"
  name        = "LOC-PRD-DB01"
  rsg         = "module"
  edition     = "Standard"
  performance = "S3"
}

# Creates an Elastic pool with DTU sizing
module "dtu_elasticpool" {
  source       = ".//elasticPoolDTU"
  buildby      = "Racker"
  buildticket  = "Build Ticket"
  environment  = "Production"
  location     = "East US 2"
  server_name  = "${module.sql_server.sql_server_name}"
  server_rsg   = "${module.sql_server.sql_server_rsg}"
  name         = "LOC-PRD-DB02"
  rsg          = "module"
  max_size     = 1024
  sku_name     = "StandardPool"
  capacity     = 200
  tier         = "Standard"
  min_capacity = 0
  max_capacity = 200
}

# Creates an Elastic pool with vCore sizing
module "vcore_elasticpool" {
  source       = ".//elasticPoolvCore"
  buildby      = "Racker"
  buildticket  = "Build Ticket"
  environment  = "Production"
  location     = "East US 2"
  server_name  = "${module.sql_server.sql_server_name}"
  server_rsg   = "${module.sql_server.sql_server_rsg}"
  name         = "LOC-PRD-DB03"
  rsg          = "module"
  max_size     = 756
  sku_name     = "GP_Gen4"
  capacity     = 2
  tier         = "GeneralPurpose"
  family       = "Gen4"
  min_capacity = 0
  max_capacity = 2
}

# Creates a database inside an Elastic pool
module "pool_sql_database" {
  source      = ".//elasticPoolDatabase"
  buildby     = "Racker"
  buildticket = "Build Ticket"
  environment = "Production"
  location    = "East US 2"
  server_name = "${module.sql_server.sql_server_name}"
  server_rsg  = "${module.sql_server.sql_server_rsg}"
  name        = "LOC-PRD-DB05"
  rsg         = "module"
  pool_name   = "${module.vcore_elasticpool.vcore_elasticpool_name}"
}
