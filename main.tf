provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "tf-test-github"
  location = "UK South"
}
