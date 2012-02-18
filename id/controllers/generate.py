import logging
import uuid

import formencode
from formencode import validators

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import validate

from id.lib.base import BaseController, render
from id.lib.auth import requires_login
from id.model import meta, Token
import id.lib.helpers as h

log = logging.getLogger(__name__)

class UUIDValidator(formencode.FancyValidator):
    def _to_python(self, value, state):
        try:
            return uuid.UUID(value)
        except ValueError:
            raise formencode.Invalid(
                "That doesn't appear to be a valid UUID",
                value, state)

class GenerateForm(formencode.Schema):
    allow_extra_fields  = True
    filter_extra_fields = True

    service_id  = formencode.All(
        validators.UnicodeString(not_empty=True),
        UUIDValidator)


class GenerateController(BaseController):

    @requires_login
    def index(self):
        c.section = 'Account'
        c.breadcrumbs = [
            h.link_to('Home', url('/')),
            h.link_to('Account', url('/account')),
            "Generate ID",
        ]
        return render('/generate/index.mako')

    @requires_login
    @validate(schema=GenerateForm(), form='index',
        text_as_default=True)
    def submit(self):
        service_id = self.form_result['service_id']
        token = meta.Session.query(Token) \
            .filter(Token.user_id==c.user.id) \
            .filter(Token.service_id==service_id) \
            .first()

        if not token:
            token = Token(
                user_id=c.user.id,
                service_id=service_id)
            meta.Session.add(token)
            meta.Session.commit()

        redirect(url(controller='generate', action='show', id=token.id))

    @requires_login
    def show(self, id):
        c.section = 'Account'
        c.breadcrumbs = [
            h.link_to('Home', url('/')),
            h.link_to('Account', url('/account')),
            "Generate ID",
        ]
        c.token = meta.Session.query(Token).get(id)

        if not c.token:
            return render('/generate/show_no_token.mako')
        else:
            return render('/generate/show.mako')



