# Logging

## Overview

Shkola uses standard Python logger. To change the logging level, change `logging.Logger.root.level = logging.DEBUG` to something else in `__init__.py`, and also change `"logging"` key in host.json. 



## Log Analytics

Shkola is configured to send logs to [Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/) on an Azure deployment. 
Here are some useful queries:

```
Logger_CL
| where type_s == "Timing" and level_d == 0
| project TimeGenerated, duration_d
| summarize min_time=min(duration_d), avg_time=avg(duration_d), max_time=max(duration_d) by bin(TimeGenerated, 1m)
| sort by TimeGenerated desc
```


```
Logger_CL 
| where type_s == "Logger" and Level == "ERROR"
| project todatetime(time_s), node_name_s, Level, function_s, line_d, filename_s, trace_s, Message 
| sort by todatetime(time_s) desc
```


```
Logger_CL 
| where type_s == "Access" 
| project todatetime(time_s), node_name_s, user_s, op_s, url_s
| sort by todatetime(time_s) desc
```


```
Logger_CL 
| where type_s == "Access" 
| project TimeGenerated, node_name_s, user_s, op_s, url_s
| summarize no_unique_users=dcount(user_s) by bin(TimeGenerated, 15m)
| sort by TimeGenerated desc
```


```
Logger_CL 
| where type_s == "Access" 
| project TimeGenerated, node_name_s, user_s, op_s, url_s
| summarize no_users=count(user_s) by bin(TimeGenerated, 15m)
| sort by TimeGenerated desc
```


```
Logger_CL 
| where type_s == "VMStatus" 
| project TimeGenerated, DiskUtilization_d, Mem_d, Swap_d, CpuUtilization_d
| summarize disk_utilization=avg(DiskUtilization_d) by bin(TimeGenerated, 5m)
| sort by TimeGenerated desc
| render timechart
```




An old query for Azure App Service:

```
union requests
| union traces
| union exceptions 
| order by timestamp desc 
| project timestamp, 
  message = iff(message != '', message, 
     iif(resultCode != '', strcat('HTTP error ', resultCode, ' - ', url), 
       iff(innermostMessage != '', innermostMessage, 
           customDimensions.['prop__{OriginalFormat}']))), 
  logLevel = iif(resultCode != '', 
     iif(resultCode != 200 and resultCode != 303, "Error", "Information"), customDimensions.['LogLevel']) 
| where logLevel == "Error" 
```


