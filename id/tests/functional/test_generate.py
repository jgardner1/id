from id.tests import *

class TestGenerateController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='generate', action='index'))
        # Test response...
