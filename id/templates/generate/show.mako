<%inherit file="/layout/basic.mako"/>
<div class="hero-unit">
  <h2>Your Unique Pseudo ID</h2>

  <p>Service URL: <a href="${c.service_url}"><code>${c.service_url}</code></a></p>

  <p>Your Unique Pseudo ID URL: <strong><code>${c.auth_url}</code></strong></p>

  <p>Password: <strong><code>${c.password}</code></strong></p>

  <p>Complete verification URL: <code>${url(c.auth_url,
  password=c.password)}</code></p>

  <p>NOTE: The password is good for a one-time use only.</p>

  <a href="${url(controller='generate', action='submit',
  service_url=c.service_url)}" class="btn btn-primary">Regenerate</a>
</div>
