# Use with Azure

Supports [Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html), [Service Principal with Client Certificate](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_certificate.html), and [Service Principal with Client Secret](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html).

## Example

``` sh
# Using Azure CLI (az login)
export ARM_SUBSCRIPTION_ID=[SUBSCRIPTION_ID]

# Using Service Principal with Client Certificate
export ARM_SUBSCRIPTION_ID=[SUBSCRIPTION_ID]
export ARM_CLIENT_ID=[CLIENT_ID]
export ARM_CLIENT_CERTIFICATE_PATH="/path/to/my/client/certificate.pfx"
export ARM_CLIENT_CERTIFICATE_PASSWORD=[CLIENT_CERTIFICATE_PASSWORD]
export ARM_TENANT_ID=[TENANT_ID]

# Service Principal with Client Secret
export ARM_SUBSCRIPTION_ID=[SUBSCRIPTION_ID]
export ARM_CLIENT_ID=[CLIENT_ID]
export ARM_CLIENT_SECRET=[CLIENT_SECRET]
export ARM_TENANT_ID=[TENANT_ID]

./terraformer import azure -r resource_group
./terraformer import azure -R my_resource_group -r virtual_network,resource_group
./terraformer import azure -r resource_group --filter=resource_group=/subscriptions/<Subscription id>/resourceGroups/<RGNAME>
```

Donwload terraformer provider

```bash
export PROVIDER=azure \
curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64  \
chmod +x terraformer-${PROVIDER}-linux-amd64 \
mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer
```

Az cli on docker

```
# https://mcr.microsoft.com/v2/azure-cli/tags/list
docker run -it -v ${HOME}/.ssh:/root/.ssh mcr.microsoft.com/azure-cli:2.28.0

docker run -it \
  -v ${HOME}/.azure:/root/.azure \
  -v ${HOME}/.ssh:/root/.ssh \
  mcr.microsoft.com/azure-cli:2.28.0
```

## List of supported Azure resources

analysis,app_service,application_gateway,container,cosmosdb,database,databricks,data_factory,disk,dns,load_balancer,eventhub,network_interface,network_security_group,network_watcher,private_dns,private_endpoint,public_ip,redis,purview,resource_group,route_table,scaleset,security_center,storage_account,synapse,virtual_machine,virtual_network,subnet,## Notes

### Virtual networks and subnets

Terraformer will import `azurerm_virtual_network` config with inlined subnet information swipped, in order to avoid any potential circular dependencies. To import the subnet information, please also import `azurerm_subnet`.
