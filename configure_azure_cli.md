
org=MyORG

https://learn.microsoft.com/es-es/azure/devops/cli/?view=azure-devops

az extension add --name azure-devops

az devops configure --defaults organization=https://dev.azure.com/${org}

az devops configure --defaults project=PaymentPlatform

https://learn.microsoft.com/es-es/azure/devops/cli/log-in-via-pat?view=azure-devops

cat my_pat_token.txt | az devops login --organization https://dev.azure.com/${org}

example:
az boards work-item show --organization https://dev.azure.com/${org} --id 1493 --query 'fields."System.Title"'