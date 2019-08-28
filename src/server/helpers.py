import cherrypy
import re


def encap_str(string):
    return "\"" + string + "\""


def create_url(self = None, page_name = None, q_id = None, l_id = None, lang = None, menu = None, js = False):
    first = True

    if js:
        glue = lambda first: " + \"" + ("?" if first else "&")
        url = page_name
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
    else:
        glue = lambda first: "?" if first else "&" 
        url = page_name
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

    return url


def is_user_on_mobile():
    headers = cherrypy.request.headers
    user_agent = headers['User-Agent'].lower()
        
    MOBILE_AGENT_RE=re.compile(r".*(iphone|mobile|androidtouch)",re.IGNORECASE)

    return MOBILE_AGENT_RE.match(user_agent)
