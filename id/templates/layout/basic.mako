<%inherit file="/layout/html5.mako"/>
<%def name="breadcrumbs()">
% if hasattr(c, 'breadcrumbs') and c.breadcrumbs:
    <ul class="breadcrumb">
% for breadcrumb in c.breadcrumbs[:-1]:
      <li>${breadcrumb} <span class="divider">/</span></li>
% endfor
% for breadcrumb in c.breadcrumbs[-1:]:
      <li class="active">${breadcrumb}</li>
% endfor
    </ul>
% endif
</%def>\
<%def name="head()">\
${parent.head()}\
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <link href="${url('/css/bootstrap.css')}" rel="stylesheet">
  <style>
    body {
      padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
    }
  </style>
  <link href="${url('/css/bootstrap-responsive.css')}" rel="stylesheet"/>
  <link href="${url('/css/id.css')}" rel="stylesheet"/>

  <link rel="shortcut icon" href="${url('/img/favicon.ico/')}">
  <link rel="apple-touch-icon" href="${url('/img/apple-touch-icon.png')}">
  <link rel="apple-touch-icon" sizes="72x72" href="${url('/img/apple-touch-icon-72x72.png')}">
  <link rel="apple-touch-icon" sizes="114x114" href="${url('/img/apple-touch-icon-114x114.png')}">
</%def>\
<%def name="header()">\
<%
    sections = dict(
        home      = h.link_to('Home', url('/')),
        develop   = h.link_to('Develop', url('/main/develop')),
        test      = h.link_to('Test', url('/main/test')),
        account   = h.link_to('Account', url('/account')),
        logout    = h.link_to('Logout', url('/logout')),
        register  = h.link_to('Register', url('/create')),
        login     = h.link_to('Login', url('/login')),
    )

    if hasattr(c, 'section'):
        current_section = c.section
    else:
        current_section = 'home'

    def render_section(section):
        attrs = dict()
        if section == current_section:
            attrs['class'] = 'active'

        return h.HTML.tag('li', sections[section], **attrs)
%>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="${url('/')}">Jonathan's ID Server</a>
          <ul class="nav">
            ${render_section('home')}
            ${render_section('develop')}
            ${render_section('test')}
          </ul>
          <ul class="nav pull-right">
% if hasattr(c, 'user'):
            ${render_section('account')}
            ${render_section('logout')}
% else:
            ${render_section('login')}
            ${render_section('register')}
% endif
          </ul>
        </div>
      </div>
    </div>
${self.breadcrumbs()}\
</%def>\
<%def name="footer()">\
<hr/>
Copyright &copy; 2012 Jonathan Gardner, ALL RIGHTS RESERVED<br/>
Contact Jonathan Gardner at <a
href="mailto:jgardner@jonathangardner.net">jgardner@jonathangardner.net</a>.
</%def>\
${self.header()}
  <div class="container">
${next.body()}
  </div>
${self.footer()}
