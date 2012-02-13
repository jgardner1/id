<%inherit file="/layout/basic.mako"/>
<form method="POST" action="${url(controller='login', action='submit')}">
<table class="horizontal">
  <tr>
    <th>Username:</th>
    <td><input type="text" name="username"/></td>
  </tr>
  <tr>
    <th>Password:</th>
    <td><input type="password" name="password"/></td>
  </tr>
  <tr>
    <th></th>
    <td>
      <button>Login</button>
      ${h.link_to('Cancel', url(controller='main'))}
    </td>
  </tr>
<table>
</form>
