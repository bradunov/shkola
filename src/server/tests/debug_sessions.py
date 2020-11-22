import logging

import os
import sys
import json

sys.path.append("../..")
sys.path.append("C:/Users/bozidar/Documents/Code/shkola/src")

from server.session import SessionDB
from server.storage_az_table import Storage_az_table


logging.basicConfig(level=logging.DEBUG, format='D: %(message)s')

# https://stackoverflow.com/a/57896847
logging.Logger.root.level = logging.DEBUG



storage = Storage_az_table()
print("Opened storage")

user_id = ""
res = storage.get_all_user_sessions(user_id)

print("\n\n")
for r in res:  
  print("User: {}, time: {}, valid: {}\n{}\n".format(r["user_id"], r["Timestamp"], r["valid"], r["data"]))


