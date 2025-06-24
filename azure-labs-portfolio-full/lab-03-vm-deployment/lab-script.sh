#!/bin/bash

# Deploy VM Web01
az vm create \
  --name vm-web01 \
  --resource-group rg-labs-core \
  --image Win2022Datacenter \
  --vnet-name vnet-lab \
  --subnet subnet-vm \
  --admin-username azureuser \
  --admin-password 'P@ssw0rd12345!' \
  --public-ip-address vm-web01-ip \
  --nsg nsg-web01 \
  --size Standard_B1ms

# Deploy VM Db01
az vm create \
  --name vm-db01 \
  --resource-group rg-labs-core \
  --image Win2022Datacenter \
  --vnet-name vnet-lab \
  --subnet subnet-db \
  --admin-username azureuser \
  --admin-password 'P@ssw0rd12345!' \
  --public-ip-address "" \
  --nsg nsg-db01 \
  --size Standard_B1ms
