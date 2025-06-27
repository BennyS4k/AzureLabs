provider "azurerm" {
  features {}

  subscription_id = "c3fcdf9b-71f4-49ca-8a17-e07277591f19"
  client_id       = "1b1d5bfc-6e7b-4b9a-827f-2b3d9fe2082c"
  client_secret   = "aEg8Q~xQW9R6oitG43uo8PkZE~yQ_WMM98bRmaoR"
  tenant_id       = "4f7487d1-4c54-4260-89e9-4ba6bfc22735"
}

resource "azurerm_resource_group" "example" {
  name     = "tf-test-github"
  location = "UK South"
}
