# Running Shkola as an Azure App Service

We have initially built shkola to also run as an Azure function. 
However, we have since dropped supporting it because we observed bad performance. 
It should still work, but it is not tested anymore. 



## Local install

The prefer install is as an Azure function. For local testing, in shkola root type:

* Install: `docker build -f src/Dockerfile --tag <username>/shkola:v0.0.1 .`

	* NOTE: This will create the dockerfile from the entire python project in shkola root dir. Every time you change the python files, this has to be done to update the docker container

* Install Azure emulator called [Azurite](https://github.com/Azure/Azurite/tree/legacy-master). 
  **IMPORTANT:** install version the old version (v2), not the new one (v3) as the new one doesn't emulate Azure tables. This is done by follwing the instructions in the link, with one important DIFFERENCE:
  type npm install -g azurite@2.7.1, instead of npm install -g azurite, as stated in the instructions, which will the latest version

+ starting Azurite by typing azurite in PowerShell

* Deploy docker with result logging in Azure table by running in a new PowerShell: `docker run -p 8080:80 --name shkola -e SHKOLA_AZ_TABLE_CONN_STR="<connection_str>" -it <username>/shkola:v0.0.1`. Use the following [test](https://docs.microsoft.com/en-us/azure/storage/common/storage-configure-connection-string) connection string for Azurite emulator: `DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;TableEndpoint=http://XX.XX.XX.XX:10002/devstoreaccount1`, where XX.XX.XX.XX is your IP address. 

*NOTE: <username> should be the same as in docker build above


* Local web access: `http://127.0.0.1:8080/main`


**NOTE:** shkola can still be deploy with result logging in local sqlite suing the following command:
`docker run -p 8080:80 --name shkola -v <local_sql_file_path>:/var/log/sql -e SHKOLA_SQL_PATH="/var/log/sql" -it <username>/shkola:v0.0.1`
However, this mode only offers browsing through questions using `http://127.0.0.1:8080/edit` URL that doesn't store any session state. 
For full access using `http://127.0.0.1:8080/main` one needs to follow the instructions above. 



## Azure install

This documentation is derived from the following [page](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=portal%2Cbash&pivots=programming-language-python).

Runes to deploy on Azure (change westeurope for preferred Azure location):
```
az group create --name <resource_group_name> --location westeurope
az storage account create --name <storage_name> --location westeurope --resource-group <resource_group_name> --sku Standard_LRS
az functionapp plan create --resource-group <resource_group_name> --name <plan_name> --location westeurope --number-of-workers 1 --sku B1 --is-linux
az functionapp create --name <function_name> --storage-account <storage_name> --resource-group <resource_group_name> --plan <plan_name> --deployment-container-image-name <username>/shkola:v0.0.1
```

NOTE: Azure currently only supports deploying function containers as web app, not as a proper scalable functions (consumption plan). For a proper functional deployment one needs to fix the runtime environment and deploy as python. See https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=bash%2Cportal&pivots=programming-language-python. To be done.

https://azure.microsoft.com/en-us/pricing/details/functions/


To register continuous integration and get your function deployed every time it is pushed to a Docker hub, first obtain a web hook:
```
az functionapp deployment container config --enable-cd --query CI_CD_URL --output tsv --name <function_name> --resource-group <resource_group_name>
```
Then log on to Docker hub and copy paste the link obtained above into the webhook tab. 
Every time you commit and push an image to Docker hub, it will get updated in the function.
More details [here](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=portal%2Cbash&pivots=programming-language-python#enable-continuous-deployment-to-azure).


To connect Azure function to the table, first go to the storage account `<storage_name>` that hosts the table and get a connection string (starting with DefaultEndpointsProtocol). Then go to the Azure function portal page, select Cofiguration from Configuration features tab and add new Application setting with name `SHKOLA_AZ_TABLE_CONN_STR` and value being the table connection string. 

For different pricing options check this [link](https://azure.microsoft.com/en-gb/pricing/details/app-service/windows/).

To buy a custom domain for your web site, check this [link](https://docs.microsoft.com/en-us/azure/app-service/manage-custom-dns-buy-domain#buy-the-domain). To add SSL certificate, check [this](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview) and [this](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-bindings) links.



### Various notes

The code is stored in `/home/site/wwwroot/` inside the container. To access it, use `docker exec -it shkola bash`.
Root access is defined through `proxies.json` file, which redirects to `main` function.
