#import cherrypy
import re

import pickle
import urllib
import base64

import logging

def encap_str(str):
    return "\"" + str + "\""

def encode_str(str):
    return urllib.parse.quote_from_bytes(base64.b64encode(str))

def decode_str(enc_str):
    return base64.b64decode(urllib.parse.unquote_to_bytes(enc_str))

def encode_dict(indict):
    return encode_str(pickle.dumps(indict))

def decode_dict(enc_dict):
    if not enc_dict:
        return {}
    else:
        return pickle.loads(decode_str(enc_dict))



def create_url(self=None, page_name=None, q_id=None, l_id=None, lang=None, state=None, menu=None, js=False):
    first = True

    # Encode state
    encoded_state = encode_dict(state)

    if js:
        glue = lambda first: " + \"" + ("?" if first else "&")
        url = "\"main\""
        if page_name is not None:
            url = url + glue(first) + "op=\" + " + page_name
            first = False
        if q_id is not None:
            url = url + glue(first) + "q_id=\" + " + q_id
            first = False
        if l_id is not None:
            url = url + glue(first) + "l_id=\" + " + l_id
            first = False
        if lang is not None:
            url = url + glue(first) + "language=\" + " + lang
            first = False
        if menu is not None:
            url = url + glue(first) + "menu=\" + " + menu
            first = False
        if state is not None:
            url = url + glue(first) + "state=\" + " + encap_str(encoded_state)
    else:
        glue = lambda first: "?" if first else "&" 
        url = "main"
        if page_name is not None:
            url = url + glue(first) + "op=" + page_name
            first = False
        if q_id is not None:
            url = url + glue(first) + "q_id=" + q_id
            first = False
        if l_id is not None:
            url = url + glue(first) + "l_id=" + l_id
            first = False
        if lang is not None:
            url = url + glue(first) + "language=" + lang
            first = False
        if menu is not None:
            url = url + glue(first) + "menu=" + menu
            first = False
        if state is not None:
            url = url + glue(first) + "state=" + encoded_state

    return url


def is_user_on_mobile(user_agent):
    # TBD:
    #headers = cherrypy.request.headers
    headers = dict()
    headers['User-Agent'] = ""
    
    user_agent = user_agent.lower()
        
    MOBILE_AGENT_RE=re.compile(r".*(iphone|mobile|androidtouch)",re.IGNORECASE)

    return MOBILE_AGENT_RE.match(user_agent)
