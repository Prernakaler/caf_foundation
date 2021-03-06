#Create the resource groups to host the blueprint
module "rg_coresec_name"{
  source  = "aztfmod/caf-naming/azurerm"
  version = "0.1.6"
  name       = var.resource_groups_hub.HUB-CORE-SEC.name
  type = "rg"
  postfix  =  "coresec"
  convention    = var.convention
}

module "rg_operations_name"{
  source  = "aztfmod/caf-naming/azurerm"
  version = "0.1.6"
  name       = var.resource_groups_hub.HUB-OPERATIONS.name
  type = "rg"
  postfix  =  "ops"
  convention    = var.convention
}

resource "azurerm_resource_group" "rg_coresec" {
  name     = rg_coresec_name.rg.result
  location = var.resource_groups_hub.HUB-CORE-SEC.location
  tags     = local.tags
}

resource "azurerm_resource_group" "rg_operations" {
  name     = rg_operations_name.rg.result
  location = var.resource_groups_hub.HUB-OPERATIONS.location
  tags     = local.tags
}

#Specify the subscription logging repositories 
module "caf-activity_logs" {
  source  = "aztfmod/caf-activity-logs/azurerm"
  version = "3.1.0"
  convention                 = var.convention
  enable_event_hub           = var.accounting_settings.azure_activity_logs_event_hub
  prefix                     = var.prefix
  resource_group_name        = azurerm_resource_group.rg_coresec.name
  location                   = var.location
  tags                       = local.tags
  log_analytics_workspace_id = module.log_analytics.id
  diagnostic_name            = var.accounting_settings.azure_activity_logs_name
  name                       = var.accounting_settings.azure_activity_logs_name
  audit_settings_object      = var.accounting_settings.azure_activity_audit
}

#Specify the operations diagnostic logging repositories 
module "diagnostics_logging" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.1.0"

  convention          = var.convention
  name                = var.accounting_settings.azure_diagnostics_logs_name
  enable_event_hub    = var.accounting_settings.azure_diagnostics_logs_event_hub
  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.rg_operations.name
  location            = var.location
  tags                = local.tags
}

#Create the Azure Monitor - Log Analytics workspace
module "log_analytics" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.3.0"

  convention          = var.convention
  prefix              = var.prefix
  name                = var.accounting_settings.analytics_workspace_name
  solution_plan_map   = var.accounting_settings.solution_plan_map
  resource_group_name = azurerm_resource_group.rg_operations.name
  location            = var.location
  tags                = local.tags
  retention_in_days   = var.accounting_settings.azure_activity_logs_retention
}