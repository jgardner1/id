<%inherit file="/layout/basic.mako"/>
<form class="well form-horizontal" method="POST" action="${url(controller='login', action='submit')}">
  <input type="hidden" name="r" value="${c.r}"/>
  <fieldset>
    <legend>Login</legend>
    <div class="control-group">
      <label class="control-label" for="username">Username:</label>
      <div class="controls">
        <input type="text" name="username"/>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="password">Password:</label>
      <div class="controls">
        <input type="password" name="password"/>
      </div>
    </div>
    <div class="form-actions">
      <input type="submit" class="btn btn-primary" value="Login"/>
      <a class="btn" href="${url('/forgot')}">I Forgot My Password</a>
      <a class="btn" href="${url('/')}">Cancel</a>
    </div>
  </fieldset>
</form>
