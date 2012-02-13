<%inherit file="/layout/basic.mako"/>

<p>Please enter the service ID below. (Future browser plugins will do this
automatically for you.)</p>
<form method="POST" action="${url(controller='generate', action='submit')}">
<table class="horizontal">
  <tr>
    <th>Service ID:</th>
    <td><input type="text" name="service_id"/></td>
  </tr>
  <tr>
    <th></th>
    <td>
      <button>Generate</button>
      ${h.link_to('Cancel', url(controller='account'))}
    </td>
  </tr>
<table>
</form>
