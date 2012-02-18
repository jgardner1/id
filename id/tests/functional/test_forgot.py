from id.tests import *

class TestForgotController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='forgot', action='index'))
        # Test response...
