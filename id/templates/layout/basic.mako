<%inherit file="/layout/html5.mako"/>
<%def name="head()">\
${parent.head()}\
    <link rel="stylesheet" href="${url('/css/style.css')}"/>
</%def>\
<%def name="header()">\
<h1>Jonathan's ID Server</h1>
% if hasattr(c, 'user'):
Welcome, ${c.user.username}! ${h.link_to('logout', url(controller='logout'))}
% else:
${h.link_to('login', url(controller='login'))}
% endif
</%def>\
<%def name="footer()">\
<hr/>
Copyright &copy; 2012 Jonathan Gardner, ALL RIGHTS RESERVED<br/>
Contact Jonathan Gardner at <a
href="mailto:jgardner@jonathangardner.net">jgardner@jonathangardner.net</a>.
</%def>\
${self.header()}
${next.body()}
${self.footer()}
