module "resource_block" {
  source = "../../module/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  depends_on = [module.resource_block]
  source     = "../../module/azurerm_networking"
  vnets      = var.vnets
}

module "container_registery" {
  depends_on          = [module.resource_block]
  source              = "../../module/container_registery"
  container_registery = var.container_registery
}


module "key_vault" {
  depends_on = [module.resource_block]
  source     = "../../module/key_vault"
  key_vault  = var.key_vault
}

module "sql_server" {
  depends_on = [ module.resource_block ]
  source = "../../module/azurerm_sql_server"
  sql_servers = var.sql_servers
}

module "sql_db" {
  depends_on = [ module.sql_server ]
  source = "../../module/azurerm_sql_database"
  sql_db_name = var.sql_db_name
  
}

module "pip" {
  depends_on = [module.resource_block]
  source     = "../../module/azurerm_public_ip"
  pip        = var.pip

}

module "nsgs" {
  depends_on = [module.resource_block]
  source     = "../../module/azurerm_nsg"
  nsg        = var.nsg

}

module "vms" {
  depends_on = [module.pip]
  source     = "../../module/azurerm_compute"
  vms        = var.vms
}
