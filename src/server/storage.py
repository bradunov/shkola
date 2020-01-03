from server.storage_az_table import storage_az_table
from server.storage_sql import storage_sql
import os
import logging


def get_storage():
    logging.debug("KEYS: " + str(os.environ))
    if 'SHKOLA_AZ_TABLE_CONN_STR' in os.environ.keys():
        logging.info("Using table storage, conn str: " + os.environ['SHKOLA_AZ_TABLE_CONN_STR'])
        return storage_az_table()
    else:
        logging.info("Using sql storage")
        return storage_sql()


