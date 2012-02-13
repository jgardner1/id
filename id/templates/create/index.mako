<%inherit file="/layout/basic.mako"/>
<h2>Create an Account With Us</h2>
<p>All we need is a unique username and a password.</p>
<p>If you give us an email address, then if you forget your password, we'll
send a reset password link to that email.</p>

<form method="POST" action="${url(controller='create', action='submit')}">
  <table class="horizontal">
    <tr>
      <th>Username:</th>
      <td><input type="text" name="username"/></td>
    </tr>
    <tr>
      <th>Email:</th>
      <td><input type="email" name="email"/></td>
    </tr>
    <tr>
      <th>Password:</th>
      <td><input type="password" name="password1"/></td>
    </tr>
    <tr>
      <th>Again:</th>
      <td><input type="password" name="password2"/></td>
    </tr>
    <tr>
      <th></th>
      <td><input type="submit"/></td>
    </tr>
  </table>
</form>
