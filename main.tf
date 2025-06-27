provider "azurerm" {
  features {}

  subscription_id = "c3fcdf9b-71f4-49ca-8a17-e07277591f19"
  client_id       = "1b1d5bfc-6e7b-4b9a-827f-2b3d9fe2082c"
  client_secret   = "aEg8Q~xQW9R6oitG43uo8PkZE~yQ_WMM98bRmaoR"
  tenant_id       = "4f7487d1-4c54-4260-89e9-4ba6bfc22735"
}

# --------------------
# Variables
# --------------------
variable "vm_admin_username" {
  description = "username for vm"
  type        = string
  default     = "bcoyne"
}

variable "vm_admin_password" {
  description = "Password for VM"
  type        = string
  sensitive   = true
}

# --------------------
# Resource Group
# --------------------
resource "azurerm_resource_group" "rg" {
  name     = "fedoratestbox-rg"
  location = "UK South"
}

# --------------------
# Virtual Network
# --------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "linuxtst-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# --------------------
# Subnet
# --------------------
resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# --------------------
# Network Security Group
# --------------------
resource "azurerm_network_security_group" "nsg" {
  name                = "fedora-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# --------------------
# NSG Association
# --------------------
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# --------------------
# Public IP
# --------------------
resource "azurerm_public_ip" "public_ip" {
  name                = "fedora-vm-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# --------------------
# Network Interface
# --------------------
resource "azurerm_network_interface" "nic" {
  name                = "fedora-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# --------------------
# Fedora Linux VM
# --------------------
resource "azurerm_linux_virtual_machine" "fedora_vm" {
  name                            = "fedoratestbox-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_D4s_v3"
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "fedora"
    offer     = "fedora"
    sku       = "38-gen2"
    version   = "latest"
  }
}

# --------------------
# Output
# --------------------
output "public_ip_address" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "Public IP address of the Fedora VM"
}
