#!/bin/bash

# Create Recovery Services Vault
az backup vault create \
  --resource-group rg-bclabs-core \
  --name backup-vault \
  --location uksouth

az backup vault backup-properties set \
  --name backup-vault \
  --resource-group rg-bclabs-core \
  --backup-storage-redundancy LocallyRedundant

# Enable backup for VM
az backup protection enable-for-vm \
  --vault-name backup-vault \
  --resource-group rg-bclabs-core \
  --vm vm-web01 \
  --policy-name DefaultPolicy
