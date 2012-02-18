import logging

import formencode
from formencode import validators

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import validate

from id.lib.base import BaseController, render
from id.lib.auth import login_with_password, InvalidLogin

log = logging.getLogger(__name__)

class PasswordMatches(formencode.FancyValidator):
    def _to_python(self, value, state):
        try:
            login_with_password(
                username=value['username'],
                password=value['password'])
        except InvalidLogin:
            raise formencode.Invalid(
                "Username-password combination doesn't exist.",
                value, state)

        return value

class LoginForm(formencode.Schema):
    allow_extra_fields  = True
    filter_extra_fields = True

    username = validators.UnicodeString(not_empty=False)
    password = validators.UnicodeString(not_empty=False)

    chained_validators = [
        PasswordMatches(),
    ]

class LoginController(BaseController):

    def index(self):
        c.r = request.params.get('r')
        return render('/login/index.mako')

    @validate(schema=LoginForm(), form='index',
        text_as_default=True)
    def submit(self):
        c.r = request.params.get('r')
        if c.r.startswith('/'):
            redirect(c.r)
        else:
            redirect(url(controller='account'))

