"""The application's model objects"""
from id.model.meta import Session, Base

import uuid
import random
import hashlib
from datetime import datetime

import sqlalchemy as sa
import sqlalchemy.dialects.postgresql

def init_model(engine):
    """Call me before using any of the tables or classes in the model"""
    Session.configure(bind=engine)

class UUID(sa.types.TypeDecorator):
    """Platform-independent GUID type.

    Uses Postgresql's UUID type, otherwise uses
    CHAR(32), storing as stringified hex values.

    """
    impl = sa.types.CHAR

    def load_dialect_impl(self, dialect):
        if dialect.name == 'postgresql':
            return dialect.type_descriptor(sqlalchemy.dialects.postgresql.UUID())
        else:
            return dialect.type_descriptor(sa.types.CHAR(32))

    def process_bind_param(self, value, dialect):
        if value is None:
            return value
        elif dialect.name == 'postgresql':
            return str(value)
        else:
            if not isinstance(value, uuid.UUID):
                return "%.32x" % uuid.UUID(value)
            else:
                # hexstring
                return "%.32x" % value

    def process_result_value(self, value, dialect):
        if value is None:
            return value
        else:
            return uuid.UUID(value)


class Password(object):
    """This is returned for user.password. It simply has an == check builtin,
which tests the SHA512 of the password and salt."""

    def __init__(self, user):
        self.user = user

    def __eq__(self, password):
        return hashlib.sha512(password.encode('utf-8')+self.user.salt).digest() \
            == self.user.password_sha512

    def __str__(self):
        return "<sha512 hashed password+salt \"%r\">" % (
            self.user.password_sha512)
        
class PasswordProperty(object):
    """This is the password attribute of User.

When set, it writes to user.password_sha512 and user.salt.

When get, it returns a Password object.
"""

    def __get__(self, instance, owner):
        if instance:
            return Password(instance)
        else:
            return self

    def __set__(self, instance, value):
        instance.salt = ''.join((chr(random.getrandbits(8)) for i in range(64)))
        instance.password_sha512 = hashlib.sha512(value.encode('utf-8')+instance.salt).digest()

class User(Base):
    """A user.

id: PKey
username: Unique username.
salt: random salt. Regenerated each time the password changes.
password_sha512: SHA512 hash of the password+salt
email: The email, if any. Not unique. (TODO: Allow multiple emails for an account.)
admin: Whether they are admin.
password: Not stored. This allows you to set and check the password.
"""

    __tablename__ = 'users'

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    username        = sa.Column(sa.types.Unicode, unique=True, nullable=False)
    salt            = sa.Column(sa.types.LargeBinary(64), nullable=False)
    password_sha512 = sa.Column(sa.types.LargeBinary(64), nullable=False)
    email           = sa.Column(sa.types.Unicode, nullable=True)
    admin           = sa.Column(sa.types.Boolean, nullable=False, default=False)

    password        = PasswordProperty()

class UserFacts(Base):
    """Facts about the user for a particular service.

id: PKey
user_id: The user the fact is for
service_id: The service the fact is shared with.
name: The fact name: string.
value: The fact value: JSON
changed: When it was last changed.
updated: When it was last sent to the server.
"""
    __tablename__ = 'user_facts'
    __table_args__ = (
        sa.UniqueConstraint('token_id', 'name'),
    )

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    token_id        = sa.Column(UUID, sa.ForeignKey('tokens.id'), nullable=False)
    name            = sa.Column(sa.types.Unicode, nullable=False)
    value           = sa.Column(sa.types.Unicode, nullable=False)
    changed         = sa.Column(sa.types.DateTime, nullable=False, default=datetime.utcnow)

    token           = sa.orm.relationship('Token',
        backref='facts')


class Service(Base):
    """A service.

id: PKey
url: The unique service URL.
update_url: The url we will send updates to.
"""
    __tablename__ = 'services'

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    url             = sa.Column(sa.types.Unicode, unique=True, nullable=False)
    update_url      = sa.Column(sa.types.Unicode, nullable=False)

class Subscription(Base):
    """Records any current subscriptions, one for each user-service-name
combination.

id: Pkey
user_id: The user whose data is requested.
service_id: The service who requested it.
name: The name of the attribute they want.
"""
    __tablename__ = 'subscriptions'
    __table_args__ = (
        sa.UniqueConstraint('token_id', 'name'),
    )

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    token_id        = sa.Column(UUID, sa.ForeignKey('tokens.id'), nullable=False)
    name            = sa.Column(sa.types.Unicode, nullable=False)

    token           = sa.orm.relationship('Token',
        backref='subscriptions')


class SubscriptionUpdate(Base):
    """Records an update event.
id: unique ID
user_id: The user whose data was updated.
service_id: The service that was updated.
url: The url that was called.
name: The name that was shared.
value: The value that was sent.
updated: when the update occurred.
"""
    __tablename__ = 'subscription_updates'

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    token_id        = sa.Column(UUID, sa.ForeignKey('tokens.id'), nullable=False)
    url             = sa.Column(sa.types.Unicode, unique=True, nullable=False)
    name            = sa.Column(sa.types.Unicode, nullable=False)
    value           = sa.Column(sa.types.Unicode, nullable=False)
    updated         = sa.Column(sa.types.DateTime, nullable=True)

    token           = sa.orm.relationship('Token',
        backref='subscription_updates')

class Token(Base):
    """Authentication tokens given to a service.

id: Unique ID, the pseudo-ID we share with the service.
user_id: The user this is for.
service_id: The service this is for.
password: The temporary password as it was last generated.
expires: When the password expires.

When we generate a Token for the first time, a random id is chosen. When the
user re-generates it for the same service the next time, we simply use a new
password.

Once the password is used successfully, we set its expiration to the time it
was used. (TODO: We may want to model this better.)

TODO: What happens when a 3rd Party Service is compromised? They might want us
to generate new unique IDS. This leads me to believe we should have our own
internal ID, and a public ID we can change at any time.
"""
    __tablename__ = 'tokens'
    __table_args__ = (
        sa.UniqueConstraint('user_id', 'service_id'),
    )

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    user_id         = sa.Column(UUID, sa.ForeignKey('users.id'), nullable=False)
    service_id      = sa.Column(UUID, sa.ForeignKey('services.id'), nullable=False)
    password        = sa.Column(sa.types.LargeBinary(64), nullable=False)
    expires         = sa.Column(sa.types.DateTime, nullable=False)

    user = sa.orm.relationship('User', backref='tokens')
    service = sa.orm.relationship('Service', backref='tokens')

    # TODO: have subscriptions act as a set of names.
