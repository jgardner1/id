<%inherit file="/layout/basic.mako"/>
<h3>This is not implemented yet. Sorry!</h3>
<form class="well form-horizontal" method="POST" action="${url(controller='forgot', action='submit')}">
  <input type="hidden" name="r" value="${c.r}"/>
  <fieldset>
    <legend>Forgot Your Password?</legend>
    <div class="control-group">
      <label class="control-label" for="email">Email:</label>
      <div class="controls">
        <input type="text" name="email"/>
        <p>We're going to look up any registration for the email you give us,
        and send you reset links.</p>
      </div>
    </div>
    <div class="form-actions">
      <input type="submit" class="btn btn-danger" value="Reset My Password"/>
      <a class="btn" href="${url('/')}">Cancel</a>
    </div>
  </fieldset>
</form>
