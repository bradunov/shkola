from server.design_dev import Design_dev
from server.design_default import Design_default
from types import *

class Design(object):

  @staticmethod
  def render_page(page):
    if page.page_params.style == PageDesign.DEFAULT:
      Design_default.render_page(page)
    elif page.page_params.style == PageDesign.DEV:
      Design_dev.render_page(page)
    else:
      Design_default.render_page(page)


  @staticmethod
  def render_menu(page):
    if page.page_params.style == PageDesign.DEFAULT:
      Design_default.render_menu(page)
    elif page.page_params.style == PageDesign.DEV:
      Design_dev.render_menu(page)
    else:
      Design_default.render_menu(page)

