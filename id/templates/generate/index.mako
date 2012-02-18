<%inherit file="/layout/basic.mako"/>
<form  class="well form-horizontal" method="POST" action="${url(controller='generate', action='submit')}">
  <fieldset>
    <legend>Generate ID For Service</legend>
    <div class="control-group">
      <label class="control-label" for="username">Service URL:</label>
      <div class="controls">
        <input type="text" name="service_id"/>
        <p class="help-block">Be sure that this is the URL that the service
        provides.</p>
      </div>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" type="submit":>Generate ID</button>
      <button class="btn" onclick="${url(controller='account')}">Cancel</button>
    </div>
  </fieldset>
</form>
