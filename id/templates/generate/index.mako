<%inherit file="/layout/basic.mako"/>
<form  class="well form-horizontal" method="POST" action="${url(controller='generate', action='submit')}">
  <fieldset>
    <legend>Generate ID For Service</legend>
    <div class="control-group">
      <label class="control-label" for="service_url">Service URL:</label>
      <div class="controls">
        <input type="url" name="service_url"/>
        <p class="help-block">Be sure that this is the URL that the service
        provides. We're going to load it to make sure that it represents an
        active service.</p>
      </div>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" type="submit">Generate ID</button>
      <button class="btn" onclick="${url(controller='account')}">Cancel</button>
    </div>
  </fieldset>
</form>
