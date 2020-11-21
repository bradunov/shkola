# Installing and running Shkola

This document describes how to install and run Shkola as a web server. 
Although Shkola design is largely framework agnostic, the supported web framework currently is [CherryPy](https://cherrypy.org/).
Similarly, Shkola design is largely cloud provider agnostic but currently supported cloud is Azure.  
We have previously ran Shkola as Azure App Service but it was much slower than a VM so we have given up on it (see [Azure App Service](azure_app_service.md) for a description).



## Local install

The local install option has been tested in Linux/bash and Windows/PowerShell. 

### Using Azurite as a local data store emulator

Shkola needs reliable and scalable data store to store question responses. We use Azure tables as the cheapest option on Azure. 
In order to test it locally, you need to install a local tables emulator. We use [Azurite](https://github.com/Azure/Azurite/tree/legacy-master). 

**IMPORTANT:** install the old version of Azurite (v2), not the new one (v3) as the new one doesn't emulate Azure tables. 
This is done by follwing the instructions in the link, with one important DIFFERENCE:
type npm install -g azurite@2.7.1, instead of npm install -g azurite, as stated in the instructions, which will the latest version

Starting Azurite by typing azurite in command line.


### Setting up the web site

Shkola runs with python3 (3.6 or greater) so make sure you have it installed and running. 
You'll also need a working `pip` setup. 

Open a shell window. In this example we use Ubuntu 18.04 and bash. 
To get shkola web server up and running, do the following:

* Install the python packages: `python -m pip install -r src/requirements.txt`

* Set the following shell variable 
  ```
     export SHKOLA_TEMPLATES="templates"
     export SHKOLA_AZ_TABLE_CONN_STR="DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1"
  ```
  The latter one is a key for your local Azurite deployment which is predefined. 

* Run: 
  ```
  cd src
  python cherrypy/main.py
  ```

* Test the local web by accessing: `http://127.0.0.1:8080/main`




## Azure install

We have automated install on Azure using a [Shkola ARM template](../src/scripts/azure/arm.json). 

To install on Azure, you will need to create:

* An Azure account. Log onto [Azure portal](https://portal.azure.com/) and create one. 

* An [Azure table](https://azure.microsoft.com/en-gb/services/storage/tables/) instance. 
  This is used to store results and feedbacks. 
  Once you have logged on to your Azure account, follow the instructions to create one.  

* An [Azure Monitor / Log Analytics workspace](https://azure.microsoft.com/en-gb/services/monitor). 
  This is optional and it is used to log your system performance and create alerts. 
  Go to the Azure portal and create one. 

Once you have these, you have to set various environment variables:
```
export SHKOLA_TEMPLATES="templates"
export SHKOLA_AZ_TABLE_CONN_STR=<your_table_credential>
export SHKOLA_LA_WORKSPACE_ID=<your_log_analytics_workspace_id>
export SHKOLA_LA_PRIMARY_KEY=<your_primary_key>
export SHKOLA_NODE_NAME=<deployment_names>
```
To get `SHKOLA_AZ_TABLE_CONN_STR` go to your Azure table and look into Access keys. Copy the entire connection string here. 
To get `SHKOLA_LA_WORKSPACE_ID` and `SHKOLA_LA_PRIMARY_KEY` go to your Log analytics workspace and look into Agent management. Copy the workspace ID and the primary key. 

Now you are ready to create your Azure deployment. Go to `src/scripts/azure/` and type `./deploy.sh <deployment-name> <location>`.
For example, type `./deploy.sh shkola_test1 westeurope` to deploy in resource group `shkola_test1` in azure region `westeurope`. 
The script will take a few minutes. Once it is done, and assuming there are no errors, you should be able to access your new web site on
`http://shkola_test1.westeurope.cloudapp.azure.com`. 

To make the deployment ready for production, please also check [this page](production.md).


