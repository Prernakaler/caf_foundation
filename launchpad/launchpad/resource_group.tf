
module "caf-naming-rg" {
  source  = "aztfmod/caf-naming/azurerm"
  version = "0.1.6"
  name = var.resource_group_name
  type = "rg"
  convention = var.convention
}
resource "azurerm_resource_group" "rg" {
  name     = module.caf-naming-rg.rg
  location = var.location
}
