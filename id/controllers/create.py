import logging
import formencode
from formencode import validators

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import validate

from id.lib.base import BaseController, render
from id.lib.auth import UniqueUsername, register
import id.lib.helpers as h

log = logging.getLogger(__name__)

class CreateForm(formencode.Schema):
    allow_extra_fields  = True
    filter_extra_fields = True

    username  = formencode.All(
        validators.UnicodeString(
            not_empty=True,
            messages=dict(
                empty='Please choose a username.')),
        UniqueUsername)
    email     = validators.Email(not_empty=False)
    password1 = validators.UnicodeString(not_empty=True)
    password2 = validators.UnicodeString(not_empty=True)

    chained_validators = [
        validators.FieldsMatch('password1', 'password2'),
    ]


class CreateController(BaseController):

    def index(self):
        c.section = 'register'
        c.breadcrumbs = [
            h.link_to('Home', url('/')),
            'Create Account',
        ]
        c.r = request.params.get('r')
        return render('/create/index.mako')

    @validate(schema=CreateForm(), form='index',
        text_as_default=True)
    def submit(self):
        register(
            username=self.form_result['username'],
            email=self.form_result['email'],
            password=self.form_result['password1'])

        c.r = request.params.get('r')
        if c.r and c.r.startswith('/'):
            redirect(c.r)
        else:
            redirect(url(controller='account'))
