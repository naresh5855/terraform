terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>3.0"
        }
    }
}
provider "azurerm" {
    features {}
}
resource "azurerm_resource_group" "ram_group" {
    name = "ram_group"
    location = "East US"
}
/*
resource "azurerm_storage_account" "ram_account" {
  count = 3 
  name                     = "${count.index}ram12345678"
  resource_group_name      = azurerm_resource_group.ram_group.name
  location                 = azurerm_resource_group.ram_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "testing"
  }
}
*/
resource "azurerm_storage_account" "ram_account" {
  for_each = toset(["data","file"])
  name                     = each.key
  resource_group_name      = azurerm_resource_group.ram_group.name
  location                 = azurerm_resource_group.ram_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "testing"
  }
}
/*
resource "azurerm_storage_container" "ram_test" {
  name                  = "vram-test"
  storage_account_name  = azurerm_storage_account.ram_account.name
  container_access_type = "blob"
  depends_on = [
      azurerm_storage_account.ram_account
  ]
}
resource "azurerm_storage_blob" "ram_test12" {
  name                   = "training.tf"
  storage_account_name   = azurerm_storage_account.ram_account.name
  storage_container_name = azurerm_storage_container.ram_test.name
  type                   = "Block"
  source                 = "training.tf"
}
*/
