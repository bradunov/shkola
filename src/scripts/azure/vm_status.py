import json
import datetime
import os
import socket
import subprocess
import sys
import traceback
import time
import socket
import logging
import requests

sys.path.append('../..')
from server.logging_azure import Logging_handler_azure
import server.helpers as helpers


workspace_id = os.getenv('SHKOLA_LA_WORKSPACE_ID')                    
primary_key = os.getenv('SHKOLA_LA_PRIMARY_KEY')
if workspace_id or primary_key:
    log_handler = Logging_handler_azure(workspace_id, primary_key)
else:
    log_handler = None
    logging.error("No Log Analytics handler, exiting!")
    exit(1)

logging.getLogger().addHandler(log_handler)


while True:
    
    try:
        # Log_analytics data
        json_data = {}

        # Filesystem usage
        stdout = subprocess.check_output('df | grep " /$"', shell=True).strip().decode('utf-8')
        filesystem_fullnesses = {}
        for line in stdout.split('\n'):
            tokens = line.split()
            filesystem_fullnesses['DiskUtilization'] = int(tokens[4][:-1])
            json_data['DiskUtilization'] = int(tokens[4][:-1])
            #print(filesystem_fullnesses)

        # Memory usage
        stdout = subprocess.check_output('free -m | grep -v total', shell=True).strip().decode('utf-8')
        mem_usage = {}
        for line in stdout.split('\n'):
            tokens = line.split()
            mem_type = tokens[0][:-1]
            mem_size = int(tokens[1])
            mem_used = int(tokens[2])
            if mem_size == 0:
                mem_percent_used = 0
            else:
                mem_percent_used = (mem_used * 100) / mem_size   
            #print(mem_type, mem_percent_used)
            mem_usage[mem_type] = mem_percent_used
            json_data[mem_type] = mem_percent_used

        # CPU time
        stdout = subprocess.check_output('mpstat 5 1 | grep Average | awk \'{ print $12 }\'', shell=True).strip()
        cpu_usagen = 100 - int(float(stdout.strip()))
        cpu_usage = { "CpuUtilization" : cpu_usagen }
        json_data["CpuUtilization"] = cpu_usagen
        #print(cpu_usage)



        # Heartbeat
        r = requests.get('http://127.0.0.1')
        if r.status_code == 200:
            json_data["Heartbeat"] = 'OK'
        else:
            json_data["Heartbeat"] = 'ERROR'



        # Send all to log_analytics
        #print(str(datetime.datetime.now()))
        #print(json_data)
        log_handler.log_json('VMStatus', json_data, upload_immediately=True)
        

        


    except Exception as e:
        logging.error("Exception: {}\n{}".format(
            e, helpers.get_stack_trace()
        ))


    time.sleep(300)
