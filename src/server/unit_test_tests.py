
import sys
sys.path.append("..")

from server.page import Page
from server.list import List

import logging
logging.basicConfig(level=logging.DEBUG)
logging.basicConfig(level=logging.DEBUG, format='AAAA: %(message)s')

# https://stackoverflow.com/a/57896847
logging.Logger.root.level = logging.DEBUG


page = Page(use_azure_blob=False, preload=True)
test = List(page)

page.page_params.set_param("subtheme", "Merenje dužine")
page.page_params.set_param("topic", "Pretvaranje jedne mere u drugu")
page.page_params.set_param("period", "*")
page.page_params.set_param("difficulty", "*")

test.choose_next_question_test()

