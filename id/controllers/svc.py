import logging
from datetime import datetime
import base64

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect
from pylons.decorators import jsonify

from id.lib.base import BaseController, render
from id.model import meta, Token, Subscription

log = logging.getLogger(__name__)

class SvcController(BaseController):

    @jsonify
    def auth(self, id):
        password = request.params.get('password')
        if not password:
            return dict(
                success=False,
                error='Expected "password" parameter',
            )

        try:
            password = base64.urlsafe_b64decode(str(password))
        except ValueError:
            return dict(
                success=False,
                error='Password is not the expected format.',
            )

        token = meta.Session.query(Token) \
            .filter(Token.id == id) \
            .filter(Token.password == password) \
            .filter(Token.expires > datetime.utcnow()) \
            .first()
        if not token:
            return dict(
                success=False,
                error='Credentials are invalid: no such user, wrong'
                    ' password, or expired.',
            )

        token.expires = datetime.utcnow()
        meta.Session.commit()
        return dict(
            success=True,
            subscribe_url=url(controller='svc', action='subscribe', id=id,
                qualified=True),
            unsubscribe_url=url(controller='svc', action='unsubscribe', id=id,
                qualified=True),
        )

    @jsonify
    def subscribe(self, id):
        token = meta.Session.query(Token) \
            .filter(Token.id == id) \
            .first()
        if not token:
            return dict(
                success=False,
                error='invalid token')

        if not request.params.getall('a'):
            return dict(
                success=False,
                error="no 'a' specified")

        for a in request.params.getall('a'):
            subscription = meta.Session.query(Subscription) \
                .filter(Subscription.token == token) \
                .filter(Subscription.name == a) \
                .first()

            if not subscription:
                meta.Session.add(Subscription(
                    token=token,
                    name=a,
                ))

        meta.Session.commit()

        return dict(success=True)

    @jsonify
    def unsubscribe(self, id):
        token = meta.Session.query(Token) \
            .filter(Token.id == id) \
            .first()
        if not token:
            return dict(
                success=False,
                error='invalid token')

        if not request.params.getall('a'):
            return dict(
                success=False,
                error="no 'a' specified")

        meta.Session.query(Subscription) \
            .filter(Subscription.token==token) \
            .filter(Subscription.name.in_(request.params.getall('a'))) \
            .delete(synchronize_session='fetch')

        meta.Session.commit()
            
        return dict(success=True)
