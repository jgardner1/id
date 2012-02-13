"""The base Controller API

Provides the BaseController class for subclassing.
"""
from pylons.controllers import WSGIController
from pylons.templating import render_mako as render
from pylons import tmpl_context as c

from id.model.meta import Session
from id.lib.auth import current_user, NotLoggedIn

class BaseController(WSGIController):

    def __before__(self):
        try:
            c.user = current_user()
        except NotLoggedIn:
            pass

    def __call__(self, environ, start_response):
        """Invoke the Controller"""
        # WSGIController.__call__ dispatches to the Controller method
        # the request is routed to. This routing information is
        # available in environ['pylons.routes_dict']
        try:
            return WSGIController.__call__(self, environ, start_response)
        finally:
            Session.remove()
