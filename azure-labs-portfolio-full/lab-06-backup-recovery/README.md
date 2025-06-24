# Lab 06 Backup Recovery

This lab is to create a backup vault within the created resource group that is locally redudant - then to add the web app VM as a protected entity.

Issue i ran into is that "defaultpolicy' variable did not pass due to the VM being trusted - this meant i had to use the EnhancedPolicy instead
