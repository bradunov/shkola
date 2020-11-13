# Set up deployment for production



## Google authentication

Useful google related links:
- Site verification: https://support.google.com/webmasters/answer/9008080?ref_topic=7440006
- OAuth2 config: https://support.google.com/webmasters/answer/9008080?ref_topic=7440006

TBD


## DNS

Create a DNS zone resource on Azure and set it to point to your VM. 


## SSL Certificate

To get an initial certificate, use the following command:
```
sudo certbot --nginx -m <email> --agree-tos -d <web_site_domain>
```
For testing, use:
```
sudo certbot --test-cert --nginx -m <email> --agree-tos -d <web_site_domain>
```
For full docs, please check:
- https://letsencrypt.org/getting-started/
- https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx


NOTE: Our ARM scripts do not automatically generate certificate. Either re-generate or copy from an existing deployment.

NOTE: Default ARM script opens port 80 (HTTP). For SSL this needs to be changed to 443 (HTTPS).

NOTE: Certbot automatically renews certificate through systemd daemon. However, this daemon is installed only on the VM where certbot is run. If you create a replica of the production VM and copy over the certificate, this will not automatically renew it.



## VM monitoring

The default ARM deployment script also deploys a [VM monitoring agent](../src/scripts/azure/vm_status.py) as a service on a VM. 
This agent occasionally runs various system probe tests. 



## Dashboards and alerts

The easiest start with logging is to use the Azure Log analytics [workbook](../src/scripts/azure/workbook.json) provided by us. 
Go to your Log analytics resouce, go to workbooks, create a new one, click on the advanced editor, and copy paste our [workbook](../src/scripts/azure/workbook.json) into the editor and save it. 
