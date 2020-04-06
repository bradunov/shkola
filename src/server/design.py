from server.design_dev import Design_dev
from server.design_default import Design_default

from server.types import PageDesign


class Design(object):

  @staticmethod
  def update_design(page):
    # At the moment we use DEV design for edit 
    # and DEFAULT for others, but this could be changed here
    if page.page_params.root == "edit":
      page.page_params.design = PageDesign.DEV
    else:
      page.page_params.design = PageDesign.DEFAULT


  @staticmethod
  def render_page(page):
    Design.update_design(page)
    if page.page_params.design == PageDesign.DEFAULT:
      Design_default.render_page(page)
    elif page.page_params.design == PageDesign.DEV:
      Design_dev.render_page(page)
    else:
      Design_default.render_page(page)


  @staticmethod
  def render_menu(page):
    Design.update_design(page)
    if page.page_params.design == PageDesign.DEFAULT:
      Design_default.render_menu(page)
    elif page.page_params.design == PageDesign.DEV:
      Design_dev.render_menu(page)
    else:
      Design_default.render_menu(page)


  @staticmethod
  def add_buttons(page, next_question_url):
    Design.update_design(page)
    if page.page_params.design == PageDesign.DEFAULT:
      Design_default.add_buttons(page, next_question_url)
    elif page.page_params.design == PageDesign.DEV:
      Design_dev.add_buttons(page, next_question_url)
    else:
      Design_default.add_buttons(page, next_question_url)


