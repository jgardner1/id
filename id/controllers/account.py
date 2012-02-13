import logging

import formencode
from formencode import validators
from formencode import htmlfill

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import validate

from id.lib.base import BaseController, render
from id.lib.auth import requires_login
from id.model import meta, Token

log = logging.getLogger(__name__)

class PasswordMatches(formencode.FancyValidator):
    def _to_python(self, value, state):
        if c.user.password != value:
            raise formencode.Invalid(
                'That password does not match your current password.',
                value, state)
        return value

class EditForm(formencode.Schema):
    allow_extra_fields  = True
    filter_extra_fields = True
    email     = validators.Email(not_empty=False)
    current_password = formencode.All(
        validators.UnicodeString(not_empty=True),
        PasswordMatches)
    password1 = validators.UnicodeString(not_empty=False)
    password2 = validators.UnicodeString(not_empty=False)

    chained_validators = [
        validators.FieldsMatch('password1', 'password2'),
    ]

class AccountController(BaseController):

    @requires_login
    def index(self):
        c.tokens = meta.Session.query(Token) \
            .filter(Token.user_id == c.user.id)
        return render('/account/index.mako')

    @requires_login
    def edit(self):
        return htmlfill.render(
            render('/account/edit.mako'),
            dict(email=c.user.email),
            text_as_default=True)

    @requires_login
    @validate(schema=EditForm(), form='edit',
        text_as_default=True)
    def submit(self):
        c.user.email = self.form_result['email']
        password = self.form_result['password1']
        if password:
            c.user.password = password

        meta.Session.commit()
        return redirect(url(controller='account'))
