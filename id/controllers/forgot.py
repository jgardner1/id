import logging

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect

from id.lib.base import BaseController, render
import id.lib.helpers as h

log = logging.getLogger(__name__)

class ForgotController(BaseController):

    def index(self):
        c.section = "Home"
        c.breadcrumbs = [
            h.link_to('Home', url('.')),
            'I Forgot My Password',
        ]
        c.r = request.params.get('r')
        return render('/forgot/index.mako')
