#!/bin/bash

# Create secure storage account
az storage account create \
  --name labstorage12345 \
  --resource-group rg-labs-core \
  --location uksouth \
  --sku Standard_LRS \
  --kind StorageV2 \
  --enable-hierarchical-namespace true \
  --allow-blob-public-access false \
  --min-tls-version TLS1_2

# Create blob container
az storage container create \
  --name blob-container \
  --account-name labstorage12345 \
  --auth-mode login
