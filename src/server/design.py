import server.design_dev as design_dev
import server.design_default as design_default

from server.types import PageDesign
from server.types import PageOperation
#from server.types import PageUserID

from server.question import Question
from server.qlist import Qlist
from server.test import Test

import server.context as context

import logging


class Design(object):

    @staticmethod
    def main(page):

        if page.page_params.get_param("root") == "edit":
            return design_dev.Design_dev.render_main_page(page)
        else:
            return design_default.Design_default.render_main_page(page)

