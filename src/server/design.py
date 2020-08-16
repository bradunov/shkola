import server.design_dev as design_dev
import server.design_default as design_default


class Design(object):

    @staticmethod
    async def main(page):

        if page.page_params.get_param("root") == "edit":
            return design_dev.Design_dev.render_main_page(page)
        else:
            return await design_default.Design_default.render_main_page(page)

