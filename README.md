# Shkola

Shkola is a web framework for testing math.


### Local install

The prefer install is as an Azure function. For local testing, in shkola root type:

* Install: `docker build -f src/Dockerfile --tag <username>/shkola:v0.0.1 .`

* Deploy with result logging in local sqlite: `docker run -p 8080:80 --name shkola -v <local_sql_file_path>:/var/log/sql -e SHKOLA_SQL_PATH="/var/log/sql" -it <username>/shkola:v0.0.1`

* Deploy with result logging in Azure table: `docker run -p 8080:80 --name shkola -e SHKOLA_AZ_TABLE_CONN_STR="<connection_str>" -it <username>/shkola:v0.0.1`

* Local web access: `http://127.0.0.1:8080/main`




### Azure install

This documentation is derived from the following [page](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=portal%2Cbash&pivots=programming-language-python)

Runes to deploy on Azure (change westeurope for preferred Azure location):
```
az group create --name <resource_group_name> --location westeurope
az storage account create --name <storage_name> --location westeurope --resource-group <resource_group_name> --sku Standard_LRS
az functionapp plan create --resource-group <resource_group_name> --name <plan_name> --location westeurope --number-of-workers 1 --sku B1 --is-linux
az functionapp create --name <function_name> --storage-account <storage_name> --resource-group <resource_group_name> --plan <plan_name> --deployment-container-image-name <username>/shkola:v0.0.1
```

To register continuous integration and get your function deployed every time it is pushed to a Docker hub, first obtain a web hook:
```
az functionapp deployment container config --enable-cd --query CI_CD_URL --output tsv --name testshkoladocker --resource-group testdoc
```
Then log on to Docker hub and copy paste the link obtained above into the webhook tab. 
Every time you commit and push an image to Docker hub, it will get updated in the function.
More details [here](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=portal%2Cbash&pivots=programming-language-python#enable-continuous-deployment-to-azure)


For different pricing options check this [link](https://azure.microsoft.com/en-gb/pricing/details/app-service/windows/)


### Logging

To change the logging level, change `logging.Logger.root.level = logging.DEBUG` to something else in `__init__.py`, 
and also change `"logging"` key in host.json. For Azure, TBD.


### Various notes

The code is stored in `/home/site/wwwroot/` inside the container. To access it, use `docker exec -it shkola bash`.

Continuous deployment can be enabled on Azure using these [instructions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=nodejs#enable-continuous-deployment).





