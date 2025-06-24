#!/bin/bash

# Allow RDP to VM Web01
az network nsg rule create \
  --resource-group rg-labs-core \
  --nsg-name nsg-web01 \
  --name Allow-RDP \
  --priority 100 \
  --access Allow \
  --protocol Tcp \
  --direction Inbound \
  --source-address-prefix <YOUR_PUBLIC_IP> \
  --source-port-range "*" \
  --destination-address-prefix "*" \
  --destination-port-range 3389

# Block all inbound to Db01
az network nsg rule create \
  --resource-group rg-labs-core \
  --nsg-name nsg-db01 \
  --name Deny-All-Inbound \
  --priority 100 \
  --access Deny \
  --protocol '*' \
  --direction Inbound \
  --source-address-prefix '*' \
  --destination-address-prefix '*' \
  --destination-port-range '*'
