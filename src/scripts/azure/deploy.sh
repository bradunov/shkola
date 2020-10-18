#!/bin/bash
source ./secrets.sh

export DEPLOYMENT="tatamata-test2"
export LOCATION="westeurope"


az group create --name $DEPLOYMENT --location $LOCATION

az group deployment validate \
   --handle-extended-json-format \
   --resource-group $DEPLOYMENT \
   --template-file arm.json \
   --mode Incremental \
   --verbose \
   --parameters "shkola_subscription=$SHKOLA_SUBSCRIPTION" \
                "shkola_region=$LOCATION" \
                "shkola_resource_group=$DEPLOYMENT" \
                "shkola_deployment=$DEPLOYMENT" \
                "shkola_ssh_key=$SHKOLA_SSH_KEY" \
                "SHKOLA_AZ_TABLE_CONN_STR=$SHKOLA_AZ_TABLE_CONN_STR" \
                "GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID" \
                "GOOGLE_SITE_VERIFICATION=$GOOGLE_SITE_VERIFICATION" \
                "SHKOLA_LA_WORKSPACE_ID=$SHKOLA_LA_WORKSPACE_ID" \
                "SHKOLA_LA_PRIMARY_KEY=$SHKOLA_LA_PRIMARY_KEY" \
                "SHKOLA_NODE_NAME=$DEPLOYMENT" 


if [ $? -eq 0 ]
then
  echo "Validation OK"
else
  echo "ERROR"
  exit 1
fi



az group deployment create \
   --handle-extended-json-format \
   --resource-group $DEPLOYMENT \
   --template-file arm.json \
   --mode Incremental \
   --verbose \
   --parameters "shkola_subscription=$SHKOLA_SUBSCRIPTION" \
                "shkola_region=$LOCATION" \
                "shkola_resource_group=$DEPLOYMENT" \
                "shkola_deployment=$DEPLOYMENT" \
                "shkola_ssh_key=$SHKOLA_SSH_KEY" \
                "SHKOLA_AZ_TABLE_CONN_STR=$SHKOLA_AZ_TABLE_CONN_STR" \
                "GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID" \
                "GOOGLE_SITE_VERIFICATION=$GOOGLE_SITE_VERIFICATION" \
                "SHKOLA_LA_WORKSPACE_ID=$SHKOLA_LA_WORKSPACE_ID" \
                "SHKOLA_LA_PRIMARY_KEY=$SHKOLA_LA_PRIMARY_KEY" \
                "SHKOLA_NODE_NAME=$DEPLOYMENT" 


ssh-keygen -f "/home/bozidar/.ssh/known_hosts" -R "$DEPLOYMENT.$LOCATION.cloudapp.azure.com"