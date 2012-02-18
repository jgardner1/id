from decorator import decorator

import formencode
from formencode import validators

from pylons import session, tmpl_context as c, url, request
from pylons.controllers.util import redirect

from id.model import meta, User

class InvalidLogin(Exception): pass
class NotLoggedIn(Exception): pass

def login(user):
    session['user.id'] = user.id
    session.save()

def login_with_password(username, password):
    user = meta.Session.query(User).filter(User.username==username).first()

    if user and user.password == password:
        login(user)
        return

    raise InvalidLogin

def logout():
    session.clear()
    session.save()

def current_user():
    try:
        id = session['user.id']
    except KeyError:
        raise NotLoggedIn

    user = meta.Session.query(User).get(id)
    if not user:
        raise NotLoggedIn
    return user

@decorator
def requires_login(f, *args, **kw):
    try:
        c.user = current_user()
    except NotLoggedIn:
        redirect(url(controller='login', r=request.path_qs))

    return f(*args, **kw)

def register(username, password, email):
    c.user = User(
        username=username,
        email=email)
    c.user.password = password

    meta.Session.add(c.user)
    meta.Session.commit()

    login(c.user)

class UniqueUsername(formencode.FancyValidator):
    def _to_python(self, value, state):
        user = meta.Session.query(User).filter(User.username==value).first()
        if user:
            raise formencode.Invalid(
                'That username is already being used by someone else. Please'
                ' choose a different username.',
                value, state)
        return value

