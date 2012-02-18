import logging
import uuid
import random
from datetime import datetime, timedelta
import base64

import formencode
from formencode import validators

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import validate

from id.lib.base import BaseController, render
from id.lib.auth import requires_login
from id.model import meta, Token, Service
import id.lib.helpers as h

log = logging.getLogger(__name__)

class GenerateForm(formencode.Schema):
    allow_extra_fields  = True
    filter_extra_fields = True

    service_url  = validators.URL(not_empty=True)


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
        post_only=False,
        on_get=True,
        text_as_default=True)
    def submit(self):
        service_url = self.form_result['service_url']
        service = meta.Session.query(Service) \
            .filter(Service.url == service_url) \
            .first()

        if not service:
            # TODO: Query for the URL. If it doesn't load, or doesn't show what we
            # expect to see, it is not a service.
            service = Service(
                url=service_url,
                update_url=service_url+'/update')
            meta.Session.add(service)

        token = meta.Session.query(Token) \
            .filter(Token.user==c.user) \
            .filter(Token.service==service) \
            .first()

        if not token:
            token = Token(user=c.user, service=service)
            meta.Session.add(token)

        token.password = ''.join((chr(random.getrandbits(8)) for i in range(64)))
        token.expires = datetime.utcnow() + timedelta(minutes=5)
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
        token = meta.Session.query(Token).get(id)
        if not token:
            return render('/generate/show_no_token.mako')

        c.service_url = token.service.url
        c.auth_url = url(
            controller='svc', action='auth',
            id=token.id,
            qualified=True)
        c.password = base64.urlsafe_b64encode(token.password)
        return render('/generate/show.mako')
