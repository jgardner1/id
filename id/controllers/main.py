import logging

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect

from id.lib.base import BaseController, render
import id.lib.helpers as h

log = logging.getLogger(__name__)

class MainController(BaseController):
    
    def index(self):
        c.section = 'home'
        c.breadcrumbs = ['Home']
        return render('/main/index.mako')

    def develop(self):
        c.section = 'develop'
        c.breadcrumbs = [h.link_to('Home', url('/')), 'Develop']
        return render('/main/develop.mako')

    def test(self):
        c.section = 'test'
        c.breadcrumbs = [h.link_to('Home', url('/')), 'Test']
        return render('/main/test.mako')

    def password(self):
        c.section = 'home'
        c.breadcrumbs = [h.link_to('Home', url('/')), 'Passwords']
        return render('/main/password.mako')
