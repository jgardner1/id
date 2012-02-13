<%inherit file="/layout/basic.mako"/>
<h2>A Universal Online ID System</h2>

<table class="horizontal">
  <tr>
    <th>Username:</th>
    <td>${c.user.username}</td>
  </tr>
  <tr>
    <th>Email</th>
    <td>${c.user.email}</td>
  </tr>
<table>

<ul>
  <li>${h.link_to("Generate PseudoID", url(controller='generate'))}</li>
  <li>${h.link_to("Modify Account", url(controller='account', action='edit'))}</li>
</ul>

<table>
  <tr>
    <th>Token ID</th>
    <th>Service ID</th>
  </tr>
% for token in c.tokens:
  <tr>
    <td>${h.link_to(token.id+u'@id.jonathangardner.net',
      url(controller='generate', action='show', id=token.id))}</td>
    <td>${token.service_id}</td>
  </tr>
% endfor
</table>

