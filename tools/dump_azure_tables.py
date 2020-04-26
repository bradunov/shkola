#!/usr/bin/python3

import os
import json
import argparse
import base64
import urllib.parse
import pickle

def dump_attribs(a, table):
    for k, v in a.items():
        if k.endswith('@odata.type'):
            continue

        if k == 'data' and table == 'sessions':
            data_str = base64.b64decode(urllib.parse.unquote_to_bytes(v))
            data = pickle.loads(data_str) if data_str else {}

            print("\t\tdata: ")
            for k1, v1 in data.items():
                if k1 == "params":
                    v1 = ", ".join(f"{a}={b}" for a,b in v1.items())

                print(f"\t\t\t{k1}={v1}")

        else:
            print(f"\t\t{k}={v}")


def dump_collection(col):
    d = col['data']

    print()
    print(f"Table: {col['name']}")

    for rec in d:
        if "attribs" in rec:
            print(f"\t{rec['odata']['id']}")
            dump_attribs(rec['attribs'], col['name'])

        else:
            print(f"\t{rec['name']}")

    print()


def dump_tables(db_path):
    file_path = os.path.join(db_path, '__azurite_db_table__.json')
    with open(file_path, "r") as f:
        j = json.load(f)

    for col in j['collections']:
        dump_collection(col)


def main():
    parser = argparse.ArgumentParser(description='Dump azurite tables.')

    parser.add_argument('db_path', help='Path to azurite storage', nargs=1)

    args = parser.parse_args()

    dump_tables(args.db_path[0])


if __name__ == "__main__":
    main()
