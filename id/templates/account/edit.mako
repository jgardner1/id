<%inherit file="/layout/basic.mako"/>
<h2>A Universal Online ID System</h2>

<form method="POST" action="${url(controller='account', action='submit')}">
<table class="horizontal">
  <tr>
    <th>Username:</th>
    <td>${c.user.username}</td>
  </tr>
  <tr>
    <th>Email</th>
    <td><input type="email" name="email"/></td>
  </tr>
  <tr>
    <th>Current Password:</th>
    <td><input type="password" name="current_password"/></td>
  </tr>
  <tr>
    <th>New Password:</th>
    <td><input type="password" name="password1"/></td>
  </tr>
  <tr>
    <th>Again:</th>
    <td><input type="password" name="password2"/></td>
  </tr>
  <tr>
    <th></th>
    <td>
      <button>Change</button>
      ${h.link_to('Cancel', url(controller='account'))}
    </td>
  </tr>
<table>
</form>

<ul>
  <li>${h.link_to("Generate PseudoID", url(controller='generate'))}</li>
  <li>${h.link_to("Modify Account", url(controller='account', action='edit'))}</li>
</ul>
