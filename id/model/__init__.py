"""The application's model objects"""
from id.model.meta import Session, Base

import uuid
import random
import hashlib

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

    def __init__(self, user):
        self.user = user

    def __eq__(self, password):
        return hashlib.sha512(password.encode('utf-8')+self.user.salt).digest() \
            == self.user.password_sha512

    def __str__(self):
        return "<sha512 hashed password+salt \"%r\">" % (
            self.user.password_sha512)
        
class PasswordProperty(object):

    def __get__(self, instance, owner):
        if instance:
            return Password(instance)
        else:
            raie

    def __set__(self, instance, value):
        instance.salt = ''.join((chr(random.getrandbits(8)) for i in range(20)))
        instance.password_sha512 = hashlib.sha512(value.encode('utf-8')+instance.salt).digest()

class User(Base):
    __tablename__ = 'users'

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    username        = sa.Column(sa.types.Unicode, unique=True, nullable=False)
    salt            = sa.Column(sa.types.LargeBinary(64), nullable=False)
    password_sha512 = sa.Column(sa.types.LargeBinary(64), nullable=False)
    email           = sa.Column(sa.types.Unicode, nullable=True)
    password        = PasswordProperty()

class Token(Base):
    __tablename__ = 'tokens'
    __table_args__ = (sa.UniqueConstraint('user_id', 'service_id'),)

    id              = sa.Column(UUID, primary_key=True, default=uuid.uuid4)
    user_id         = sa.Column(UUID, sa.ForeignKey('users.id'),
        nullable=False)
    service_id      = sa.Column(UUID, nullable=False)
