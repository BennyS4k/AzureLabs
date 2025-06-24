#!/bin/bash

# Create secure storage account
az storage account create \
  --name bcblob001 \
  --resource-group rg-bclabs-core \
  --location uksouth \
  --sku Standard_LRS \
  --kind StorageV2 \
  --enable-hierarchical-namespace true \
  --allow-blob-public-access false \
  --min-tls-version TLS1_2

# Create blob container
az storage container create \
  --name blob-container \
  --account-name bcblob001 \
  --auth-mode login
