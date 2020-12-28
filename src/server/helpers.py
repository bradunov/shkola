#import cherrypy
import re
import string

import os
import pickle
import urllib
import base64
import inspect
import logging



def set_log_level(log_level=None):
    logging.basicConfig(level=logging.ERROR)
    # https://stackoverflow.com/a/57896847
    logging.Logger.root.level = logging.ERROR

    if not log_level:
        log_level = os.getenv('SHKOLA_LOG_LEVEL')

    if log_level:
        log_level = log_level.upper().strip()
        if log_level == "DEBUG":
            logging.basicConfig(level=logging.DEBUG)
            logging.Logger.root.level = logging.DEBUG
        elif log_level == "INFO":
            logging.basicConfig(level=logging.INFO)
            logging.Logger.root.level = logging.INFO
        elif log_level == "INFO":
            logging.basicConfig(level=logging.WARNING)
            logging.Logger.root.level = logging.WARNING

    


def get_stack_trace():
    output = "Stack trace:\n"
    cnt = 0
    for l in inspect.stack():
        # Skip the first two because they are inside get_stack_trace() and can confuse
        if cnt >= 2:
            output = output + "  Filename: {}, Line: {}, Function: {}, Code:\n    ".format(l.filename, l.lineno, l.function)
            for h in l.code_context:
                output = output + h
        cnt += 1
    return output


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


MOBILE_AGENT_RE=re.compile(r".*(iphone|mobile|androidtouch)",re.IGNORECASE)

def is_user_on_mobile(user_agent):    
    user_agent = user_agent.lower()        
    return MOBILE_AGENT_RE.match(user_agent)



class Transliterate(object):

    # Fast python 3.5+ transliteration
    trans_cyr_lat = str.maketrans(
        "АаБбВвГгДдЂђЕеЖжЗзИиКкЛлМмЈјНнОоПпРрСсТтЋћУуФфХхЦцЧчШш",
        "AaBbVvGgDdĐđEeŽžZzIiKkLlMmJjNnOoPpRrSsTtĆćUuFfHhCcČčŠš"
    )

    trans_lat_cyr = str.maketrans(
        "AaBbVvGgDdĐđEeŽžZzIiKkLlMmJjNnOoPpRrSsTtĆćUuFfHhCcČčŠš",
        "АаБбВвГгДдЂђЕеЖжЗзИиКкЛлМмЈјНнОоПпРрСсТтЋћУуФфХхЦцЧчШш"
    )

    # Special case for 2->1 transliteration    
    mapping_rs_2_1 = [
        ['Ђ', 'Дј'], 
        ['ђ', 'дј'],
        ['Џ', 'Дж'], 
        ['џ', 'дж'],
        ['Љ', 'Лј'], 
        ['љ', 'лј'],
        ['Њ', 'Нј'], 
        ['њ', 'нј'],
    ]

    
    # Match shkola exprepressions ( @blabla@ ), MathJS expressions ( \(blabla\) )
    # or unicode expressions ( &blabla; )
    regex_pattern = re.compile(r"@.*?@|[\\][\(].*?[\\][\\)]|&.*?;")

    

    # Return transliterated string and the difference in length due to special characters
    @staticmethod
    def rs(input, lat2cyr=True):
        if lat2cyr:
            output = input.translate(Transliterate.trans_lat_cyr)
            for m in Transliterate.mapping_rs_2_1:
                output = output.replace(m[1], m[0])
        else:
            output = input.translate(Transliterate.trans_cyr_lat)
            for m in Transliterate.mapping_rs_2_1:
                output = output.replace(m[0], m[1])
        return output





    @staticmethod
    def transliterate(input, func):
        special_strings = Transliterate.regex_pattern.finditer(input)

        if not special_strings:
            output = func(input)
            return output

        output = ""
        start = 0

        for match in special_strings:
            b, e = match.span()
            #print(b,e, input[start:b])
            output += func(input[start:b])
            output += input[b:e]
            start = e

        output += func(input[start:len(input)])
        return output



if __name__ == "__main__":
    s = """Koristeći cifre @hspace8pt@ @array_cifre[3]@, @hspace8pt@ @array_cifre[2]@ @hspace8pt@ i @hspace8pt@ @array_cifre[1]@ @hspace8pt@ zapiši sve dvocifrene brojeve redom od najvećeg do najmanjeg. Cifre mogu da se ponavljaju.
@vspace@
&middot;
\\(\\frac{(1-2)}\\{3-4}\\)
@center@ @hspace@ @lib.check_number(array_value[1])@ @hspace@ @lib.check_number(array_value[2])@ @hspace@ @lib.check_number(array_value[3])@
@center@ @hspace@ @lib.check_number(array_value[4])@ @hspace@ @lib.check_number(array_value[5])@ @hspace@ @lib.check_number(array_value[6])@
@center@ @hspace@ @lib.check_number(array_value[7])@ @hspace@ @lib.check_number(array_value[8])@ @hspace@ @lib.check_number(array_value[9])@
\\(\\frac{(1-2)}\\{3-4}\\)
&middot;
"""

    print(Transliterate.transliterate(s, Transliterate.rs))
