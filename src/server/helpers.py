#import cherrypy
import re

import pickle
import urllib
import base64


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



class Transliterate(object):
    mapping_rs = [
        ['А', 'A'], 
        ['а', 'a'],
        ['Б', 'B'], 
        ['б', 'b'],
        ['В', 'V'], 
        ['в', 'v'],
        ['Г', 'G'], 
        ['г', 'g'],
        ['Ђ', 'Dj'], 
        ['ђ', 'dj'],
        ['Џ', 'Dž'], 
        ['џ', 'dž'],
        ['Д', 'D'], 
        ['д', 'd'],
        ['Ђ', 'Đ'], 
        ['ђ', 'đ'],
        ['Е', 'E'], 
        ['е', 'e'],
        ['Ж', 'Ž'], 
        ['ж', 'ž'],
        ['З', 'Z'], 
        ['з', 'z'],
        ['И', 'I'], 
        ['и', 'i'],
        ['К', 'K'], 
        ['к', 'k'],
        ['Љ', 'Lj'], 
        ['љ', 'lj'],
        ['Л', 'L'], 
        ['л', 'l'],
        ['М', 'M'], 
        ['м', 'm'],
        ['Њ', 'Nj'], 
        ['њ', 'nj'],
        ['Ј', 'J'], 
        ['ј', 'j'],
        ['Н', 'N'], 
        ['н', 'n'],
        ['О', 'O'], 
        ['о', 'o'],
        ['П', 'P'], 
        ['п', 'p'],
        ['Р', 'R'], 
        ['р', 'r'],
        ['С', 'S'], 
        ['с', 's'],
        ['Т', 'T'], 
        ['т', 't'],
        ['Ћ', 'Ć'], 
        ['ћ', 'ć'],
        ['У', 'U'], 
        ['у', 'u'],
        ['Ф', 'F'], 
        ['ф', 'f'],
        ['Х', 'H'], 
        ['х', 'h'],
        ['Ц', 'C'], 
        ['ц', 'c'],
        ['Ч', 'Č'], 
        ['ч', 'č'],
        ['Ш', 'Š'], 
        ['ш', 'š']
    ]

    @staticmethod
    def rs(input, lat2cyr=True):
        output = input
        if lat2cyr:
            for m in Transliterate.mapping_rs:
                output = output.replace(m[1], m[0])
        else:
            for m in Transliterate.mapping_rs:
                output = output.replace(m[0], m[1])
        return output


    @staticmethod
    def transliterate(input, func):
        start = 0
        cnt = 0
        if input[0] == "@":
            input = " " + input

        while not start == 1:
            end = input.find("@", start+1)
            if end == -1:
                break
            print("\nL {}-{}:{}".format(start, end, input[start:end]))
            input = input[:start] + func(input[start:end]) + input[end:]
            print("\nO: {}".format(input))
            start = input.find("@", end+1)
            cnt = cnt + 1
            if cnt > 10:
                break
        return input
