<%inherit file="/layout/basic.mako"/>
<form class="well form-horizontal" method="POST" action="${url(controller='create', action='submit')}">
  <input type="hidden" name="r" value="${c.r}"/>
  <fieldset>
    <legend>Register</legend>
    <div class="control-group">
      <label class="control-label" for="username">Username:</label>
      <div class="controls">
        <input type="text" name="username"/>
        <p>Do not share this with anyone.</p>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="email">Email:</label>
      <div class="controls">
        <input type="email" name="email"/>
        <p>If you forget your password, we'll send an email with reset links.</p>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="password1">Password:</label>
      <div class="controls">
        <input type="password" name="password1"/>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="password2">Again:</label>
      <div class="controls">
        <input type="password" name="password2"/>
        <p><a href="${url('/main/password')}">We store your password
          securely.</a></p>
      </div>
    </div>
    <div class="form-actions">
      <input type="submit" class="btn btn-primary" value="Register"/>
      <a class="btn" href="${url('/')}">Cancel</a>
    </div>
  </fieldset>
</form>
