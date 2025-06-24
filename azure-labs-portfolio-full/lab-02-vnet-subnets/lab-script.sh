#!/bin/bash

# Create VNet and subnets
az network vnet create \
  --name vnet-lab \
  --resource-group rg-bclabs-core \
  --address-prefix 10.0.0.0/16 \
  --subnet-name subnet-vm \
  --subnet-prefix 10.0.1.0/24

az network vnet subnet create \
  --name subnet-db \
  --vnet-name vnet-lab \
  --resource-group rg-bclabs-core \
  --address-prefix 10.0.2.0/24
