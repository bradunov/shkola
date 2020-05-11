# Shkola

Shkola is a web framework for testing math.


### Environment

Shkola is built to be agnostic to the choice of a web server. 
We currently run on Azure functions and CherryPy (tested on Linux and Windows).



### Local install

The prefer install is as an Azure function. For local testing, in shkola root type:

* Install: `docker build -f src/Dockerfile --tag <username>/shkola:v0.0.1 .`

* Install Azure emulator called [Azurite](https://github.com/Azure/Azurite/tree/legacy-master). 
  **IMPORTANT:** install version the old version (v2), not the new one (v3) as the new one doesn't emulate Azure tables. 

* Deploy with result logging in Azure table: `docker run -p 8080:80 --name shkola -e SHKOLA_AZ_TABLE_CONN_STR="<connection_str>" -it <username>/shkola:v0.0.1`. Use the following [test](https://docs.microsoft.com/en-us/azure/storage/common/storage-configure-connection-string) connection string for Azurite emulator: `DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;TableEndpoint=http://XX.XX.XX.XX:10002/devstoreaccount1`, where XX.XX.XX.XX is your IP address. 

* Local web access: `http://127.0.0.1:8080/main`


**NOTE:** shkola can still be deploy with result logging in local sqlite suing the following command:
`docker run -p 8080:80 --name shkola -v <local_sql_file_path>:/var/log/sql -e SHKOLA_SQL_PATH="/var/log/sql" -it <username>/shkola:v0.0.1`
However, this mode only offers browsing through questions using `http://127.0.0.1:8080/edit` URL that doesn't store any session state. 
For full access using `http://127.0.0.1:8080/main` one needs to follow the instructions above. 



### Azure install

This documentation is derived from the following [page](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=portal%2Cbash&pivots=programming-language-python).

Runes to deploy on Azure (change westeurope for preferred Azure location):
```
az group create --name <resource_group_name> --location westeurope
az storage account create --name <storage_name> --location westeurope --resource-group <resource_group_name> --sku Standard_LRS
az functionapp plan create --resource-group <resource_group_name> --name <plan_name> --location westeurope --number-of-workers 1 --sku B1 --is-linux
az functionapp create --name <function_name> --storage-account <storage_name> --resource-group <resource_group_name> --plan <plan_name> --deployment-container-image-name <username>/shkola:v0.0.1
```

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



### Local install with CherryPy

It is also possible to run Shkola on Linux and Windows (and possibly other OSs) with CherryPy. To do so:

* Install the same requirements as for Azure functions: `python -m pip install -r src/requirements.txt`

* Install CherryPy: `python -m pip install cherrypy`

* Run: `python src/server/www.py`

* Local web access: `http://127.0.0.1:8080/main`




### Logging

To change the logging level, change `logging.Logger.root.level = logging.DEBUG` to something else in `__init__.py`, 
and also change `"logging"` key in host.json. For Azure, TBD.

To see the logs on Azure, go to the function page on the portal, select Application Insight, and then Logs. 
To see requests, search for `requests` in the log query. To see logs, search for `traces`. One useful query to see logs is
```
union traces| union exceptions| where timestamp > ago(1d) | order by timestamp desc | project timestamp, message = iff(message != '', message, iff(innermostMessage != '', innermostMessage, customDimensions.['prop__{OriginalFormat}'])), logLevel = customDimensions.['LogLevel']
```




### Various notes

The code is stored in `/home/site/wwwroot/` inside the container. To access it, use `docker exec -it shkola bash`.

Root access is defined through `proxies.json` file, which redirects to `main` function.


Useful google related links:
- Site verification: https://support.google.com/webmasters/answer/9008080?ref_topic=7440006
- OAuth2 config: https://support.google.com/webmasters/answer/9008080?ref_topic=7440006

