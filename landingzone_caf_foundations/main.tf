provider "azurerm" {
  features {}
}
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
      version = "0.4.3"
    }
  }
}

locals {
  landingzone_tag = {
    "landingzone" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.landingzone_tag)
}

locals {
  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  prefix          = var.prefix == null ? local.global_settings.prefix : var.prefix
  environment     = local.global_settings.environment
  tags_hub        = merge({ "environment" = local.environment }, var.global_settings.tags_hub)
}