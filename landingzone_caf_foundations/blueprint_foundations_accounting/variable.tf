
variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"
  default = { "aaa": "aaa-", "acr": "acr", "afw": "afw-", "asr": "asr-", "evh": "evh-", "gen": "gen", "kv": "kv-", "la": "la", "lb": "lb", "nic": "nic-", "nsg": "nsg-", "pip": "pip-", "rg": "rg-", "snet": "snet-", "st": "st", "vm": "vm-", "vml": "vm-", "vmw": "vm-", "vnet": "vnet-" }
}

variable "resource_groups_hub" {
  description = "(Required) Contains the resource groups object to be created for hub"
}

# Example:
# resource_groups = {
#     apim          = { 
#                     name     = "-apim-demo"
#                     location = "southeastasia" 
#     },
#     networking    = {    
#                     name     = "-networking-demo"
#                     location = "eastasia" 
#     },
#     insights      = { 
#                     name     = "-insights-demo"
#                     location = "francecentral" 
#                     tags     = {
#                       project     = "Pattaya"
#                       approver     = "Gunter"
#                     }   
#     },
# }

variable "location" {
  description = "Azure region to create the resources"
  type        = string
  default =     "southeastasia"
}

variable "tags_hub" {
  description = "map of the tags to be applied"
  type        = map(string)
}
variable "tags" {}

variable "convention" {

}

variable "accounting_settings" {

}