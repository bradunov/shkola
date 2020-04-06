#import cherrypy
import re

import pickle
import urllib
import base64

import logging

def encap_str(s : str):
    return "\"" + s + "\""

def encode_str(s : str):
    return urllib.parse.quote_from_bytes(base64.b64encode(s))

def decode_str(enc_str : str):
    return base64.b64decode(urllib.parse.unquote_to_bytes(enc_str))

def encode_dict(indict : dict):
    return encode_str(pickle.dumps(indict))

def decode_dict(enc_dict : str):
    if not enc_dict:
        return {}
    else:
        return pickle.loads(decode_str(enc_dict))

def extract_dict_from_post(body):
    # Can't think of a better way (without an extra copy) to extract POST arguments
    s = body.decode("utf-8")
    edict = urllib.parse.parse_qs(s)
    args = {}
    for k,v in edict.items():
        args[k] = v[0]
    return args


def is_user_on_mobile(user_agent):    
    user_agent = user_agent.lower()        
    MOBILE_AGENT_RE=re.compile(r".*(iphone|mobile|androidtouch)",re.IGNORECASE)
    return MOBILE_AGENT_RE.match(user_agent)


