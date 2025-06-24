# Lab 03 Vm Deployment

This lab is to create two Virtual machines - one for a web application and one for database purposes

The script and code initially didnt work as you can see in the "lab03-failed.png" screenshot - this is because the VM size SKU was not available in my region (UKSouth) - but running the below:

az vm list-skus \
  --location uksouth \
  --resource-type virtualMachines \
  --output table


I can see all available region specific SKUs for UK South - which then allowed me to create the VMS
