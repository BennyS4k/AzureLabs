#!/bin/bash

# Create Log Analytics Workspace
az monitor log-analytics workspace create \
  --resource-group rg-labs-core \
  --workspace-name log-lab \
  --location uksouth

# Enable diagnostic settings for VM
az monitor diagnostic-settings create \
  --name vm-web01-logs \
  --resource vm-web01 \
  --resource-group rg-labs-core \
  --workspace log-lab \
  --logs '[{"category": "AllLogs","enabled": true}]' \
  --metrics '[{"category": "AllMetrics","enabled": true}]'

# Create CPU usage alert
az monitor metrics alert create \
  --name HighCPUAlert \
  --resource-group rg-labs-core \
  --scopes $(az vm show -g rg-labs-core -n vm-web01 --query id -o tsv) \
  --condition "avg Percentage CPU > 80" \
  --description "Alert on high CPU" \
  --window-size 5m \
  --evaluation-frequency 1m
