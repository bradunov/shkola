import requests
import datetime
import hmac
import hashlib
import base64
import json
from urllib.parse import quote as url_quote
from types import SimpleNamespace
import asyncio
import httpx
import logging


import os


class AzureTableAsync():
    
    _conn_params = {
        "DefaultEndpointsProtocol" : "https",
        "EndpointSuffix" : "core.windows.net"
    }




    # Shared key authentification: https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key
    # The actual code extracted from https://github.com/Azure/azure-cosmos-table-python/tree/master/azure-cosmosdb-table
    # C# example: https://docs.microsoft.com/en-us/azure/storage/common/storage-rest-api-auth
    # Full tables REST API: https://docs.microsoft.com/en-us/rest/api/storageservices/table-service-rest-api

    def _get_authorization(self, op, date_str, resource):
        key_bytes = base64.b64decode(self._conn_params["AccountKey"].encode('utf-8'))

        string_to_sign = ""
        if op == "GET" or op == "DELETE":
            #string_to_sign = "GET\n\n\nSun, 21 Jun 2020 22:12:58 GMT\n/tatamata/Tables"
            string_to_sign = "{}\n\n\n{}\n/{}/{}".format(op, date_str, self._conn_params["AccountName"], resource)
        else: 
            # op == "POST" or op == "MERGE" ...
            #string_to_sign=b'POST\n\napplication/json\nSat, 27 Jun 2020 21:28:47 GMT\n/tatamata/users'
            string_to_sign = "{}\n\napplication/json\n{}\n/{}/{}".format(op, date_str, self._conn_params["AccountName"], resource)
        string_to_sign_b = string_to_sign.encode('utf-8')
        #print("String to sign: {}".format(string_to_sign_b))
        signed_hmac_sha256 = hmac.HMAC(key_bytes, string_to_sign.encode('utf-8'), hashlib.sha256)
        digest = signed_hmac_sha256.digest()
        encoded_digest = base64.b64encode(digest).decode('utf-8')

        # print("get_authorization date={}\n string_to_sign={}\n digest={}\n encoded_digest={}\n".format(
        #     date_str, string_to_sign_b, digest, encoded_digest))
        
        return 'SharedKey ' + self._conn_params["AccountName"] + ':' + encoded_digest


    def _make_uri(self, resource, params=""):
        return self._conn_params["TableEndpoint"] + resource + params


    def _make_headers(self, op, resource):
        headers = {}
        # GMT and UTC are the same: https://www.differencebetween.com/difference-between-gmt-and-utc/
        now = datetime.datetime.utcnow()
        headers["x-ms-date"] = now.strftime('%a, %d %b %Y %H:%M:%S GMT')
        headers["x-ms-version"] = "2017-04-17"
        headers["Authorization"] = self._get_authorization(op, headers["x-ms-date"], resource)

        #https://docs.microsoft.com/en-us/rest/api/storageservices/payload-format-for-table-service-operations
        headers["Accept"] = "application/json;odata=nometadata"
        #headers["Accept"] = "application/json;odata=minimalmetadata"
        #headers["Accept"] = "application/json;odata=fullmetadata"

        return headers


    def _make_data(self, data):
        if isinstance(data, bytes):
            return data

        data = json.dumps(data)
        return data.encode('utf-8')



    async def _make_get_req(self, resource, params=""):
        async with httpx.AsyncClient() as client:
            r = None
            try:
                r = await client.get(
                    self._make_uri(resource, params), 
                    headers=self._make_headers("GET", resource)
                )
                r.raise_for_status()
            except httpx.HTTPError as exc:
                logging.error(f"An error occured while requesting {exc.request.url!r}.")
        return r


    async def _make_post_req(self, resource, data):
        headers = self._make_headers("POST", resource)
        headers['Content-Type'] = 'application/json'
        data = self._make_data(data)
        #print("DATA: ", data)
        async with httpx.AsyncClient() as client:
            r = await client.post(
                self._make_uri(resource), 
                headers=headers,
                data=data
            )
        return r


    async def _make_merge_req(self, resource, data):
        headers=self._make_headers("MERGE", resource)
        headers['Content-Type'] = 'application/json'
        async with httpx.AsyncClient() as client:
            r = await client.request(
                "MERGE", 
                self._make_uri(resource), 
                headers=headers,
                data=self._make_data(data)
            )
        return r


    async def _make_delete_req(self, resource, data=None):
        headers=self._make_headers("DELETE", resource)
        headers["If-Match"] = "*"
        async with httpx.AsyncClient() as client:
            if data:
                r = await client.request(
                    "DELETE", 
                    self._make_uri(resource), 
                    headers=headers,
                    data=self._make_data(data)
                )
            else:
                r = await client.request(
                    "DELETE", 
                    self._make_uri(resource), 
                    headers=headers
                )
        return r


    def _get_json(self, req):
        r_json = {}
        try:
            r_json = req.json()
        except:
            pass
        return r_json


    def _check_error(self, json):
        if "odata.error" in json.keys():
            return True
        return False



    def _parse_connection_string(self, connection_string):
        #DefaultEndpointsProtocol=https;AccountName=tatamata;AccountKey=5ckDVrGf0dTb85x8TuwyN+P9kz9wiS2vnpw8xlBScWv1tGJ5M4hLWbwjvZxAcHqxF3sC6aMABPqK6uXFuVa1dA==;EndpointSuffix=core.windows.net
        #TableEndpoint
        params = connection_string.split(";")
        for s in params:
            i = s.find("=")
            key = s[0:i]
            val = s[i+1:]
            self._conn_params[key] = val
        if not "TableEndpoint" in self._conn_params.keys():
            self._conn_params["TableEndpoint"] = "https://{}.table.core.windows.net/".format(
                self._conn_params["AccountName"])
        if self._conn_params["TableEndpoint"][-1] != '/':
            self._conn_params["TableEndpoint"] = self._conn_params["TableEndpoint"] + '/'



    def __init__(self, connection_string):
        self._parse_connection_string(connection_string)



    async def async_list_tables(self):
        resource = "Tables"
        resource = url_quote(resource, '/()$=\',~')
        r = await self._make_get_req(resource)
        resp = []
        # print(r.url)
        # print(r.text)
        r_json = self._get_json(r)
        if self._check_error(r_json):
            return []
        for t in r_json["value"]:
            resp.append(SimpleNamespace(**{"name" : t["TableName"]}))
        return resp


    async def async_get_entity(self, table_name, filter=None, partition_key=None, row_key=None, select=None):
        if not row_key is None and not partition_key is None:
            resource = "{}(PartitionKey='{}',RowKey='{}')".format(table_name, partition_key, row_key)
        elif not partition_key is None:
            resource = "{}(PartitionKey='{}')".format(table_name, partition_key)
        elif not row_key is None:
            resource = "{}(RowKey='{}')".format(table_name, row_key)
        else:
            resource = "{}()".format(table_name)
        resource = url_quote(resource, '/()$=\',~')
        params = ""
        if filter:
            params = "?$filter={}".format(filter)
        if select:
            params = params + "?$select={}".format(select)            
        r = await self._make_get_req(resource, params)
        print(r.url)
        # print(r.text)
        r_json = self._get_json(r)
        if self._check_error(r_json):
            return []
        if "value" in r_json:
            return r_json["value"]
        else:
            return r_json



    # Insert record. Return True if successful, False if already exists
    async def async_insert_entity(self, table_name, entry):
        resource = table_name
        resource = url_quote(resource, '/()$=\',~')
        r = await self._make_post_req(resource, entry)
        # print(r.url)
        # print(r.text)
        r_json = self._get_json(r)
        if self._check_error(r_json):
            return False
        else:
            return True



    async def async_insert_or_merge_entity(self, table_name, entry):
        partition_key = entry["PartitionKey"].replace('\'', '\'\'')
        row_key = entry["RowKey"].replace('\'', '\'\'')
        resource = '{0}(PartitionKey=\'{1}\',RowKey=\'{2}\')'.format(
            table_name,
            partition_key,
            row_key
        )
        resource = url_quote(resource, '/()$=\',~')
        r = await self._make_merge_req(resource, entry)
        # print(r.url)
        # print(r.text)



    # Delete record. Return True if successful, False if not found
    async def async_delete_entity(self, table_name, partition_key, row_key):
        partition_key = partition_key.replace('\'', '\'\'')
        row_key = row_key.replace('\'', '\'\'')
        resource = '{0}(PartitionKey=\'{1}\',RowKey=\'{2}\')'.format(
            table_name,
            partition_key,
            row_key
        )
        resource = url_quote(resource, '/()$=\',~')
        r = await self._make_delete_req(resource)
        # print(r.url)
        # print(r.text)
        r_json = self._get_json(r)
        if self._check_error(r_json):
            return False
        else:
            return True



if __name__ == '__main__':

    async def main():
        # The test doesn't work with Azurite but works with Azure
        connection_string = os.environ['SHKOLA_AZ_TABLE_CONN_STR']
        connection_string = "DefaultEndpointsProtocol=https;AccountName=tatamata;AccountKey=5ckDVrGf0dTb85x8TuwyN+P9kz9wiS2vnpw8xlBScWv1tGJ5M4hLWbwjvZxAcHqxF3sC6aMABPqK6uXFuVa1dA==;EndpointSuffix=core.windows.net"
        print(connection_string)


        az_table = AzureTableAsync(connection_string)

        all_tables = await az_table.async_list_tables()
        print("\n\nAll tables:", all_tables)
        # print("\nB:", az_table.async_get_entity("users", ""))
        # print("\nC:", az_table.async_get_entity("users", "user_language eq 'rs'"))

        data = {
            'Timestamp': '2020-06-13T06:41:50.634Z', 
            'user_id': 'local:TEST', 
            'user_language': 'rs', 
            'name': 'TEST', 
            'email': None, 
            'remote_ip': None, 
            'user_agent': 'Mozilla/5.0', 
            'last_accessed': '1592030510', 
            'PartitionKey': 'USER', 
            'RowKey': 'local:TEST'
        }


        # The first delete may or may not succeed
        deleted = await az_table.async_delete_entity(
            "users", 
            partition_key=data["PartitionKey"], 
            row_key=data["RowKey"]
        )

        deleted = await az_table.async_delete_entity(
            "users", 
            partition_key=data["PartitionKey"], 
            row_key=data["RowKey"]
        )

        assert(deleted == False)
        print("Deleted: {} {}".format(data["PartitionKey"], data["RowKey"]))



        inserted = await az_table.async_insert_entity("users", data)
        assert(inserted == True)
        print("Insert: {} {}".format(data["PartitionKey"], data["RowKey"]))



        read_data = await az_table.async_get_entity(
            "users", 
            partition_key=data["PartitionKey"], 
            row_key=data["RowKey"]
        )
        assert(read_data["user_id"] == data["user_id"])
        print("\n\nRead:", read_data)


        data["user_id"] = "AAAAAAAAAAA"
        await az_table.async_insert_or_merge_entity("users", data)
        print("Inserted or merged: {} {}".format(data["PartitionKey"], data["RowKey"]))


        read_data = await az_table.async_get_entity(
            "users", 
            partition_key=data["PartitionKey"], 
            row_key=data["RowKey"]
        )
        assert(read_data["user_id"] == data["user_id"])
        print("\n\nRead:", read_data)


        # The first delete may or may not succeed
        deleted = await az_table.async_delete_entity(
            "users", 
            partition_key=data["PartitionKey"], 
            row_key=data["RowKey"]
        )
        assert(deleted == True)
        print("Deleted: {} {}".format(data["PartitionKey"], data["RowKey"]))

        print("\n\n")



    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())    
    
    # No need to close here as this is the global loop and will be closed by Python
    #loop.close()

