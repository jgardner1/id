import logging

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect

from id.lib.base import BaseController, render
from id.lib.auth import logout

log = logging.getLogger(__name__)

class LogoutController(BaseController):

    def index(self):
        logout()
        redirect(url(controller='main'))
