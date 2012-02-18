<%inherit file="/layout/basic.mako"/>
<div class="hero-unit">
<h1>Jonathan's ID Server</h1>
<h2>A Universal Online ID System</h2>

<p>A simple universal, distributed authentication system for the entire
world.</p>

${h.link_to('Register',
        url(controller='create'),
        class_="btn btn-primary btn-large")}

${h.link_to('Generate ID',
        url(controller='generate'),
        class_="btn btn-primary btn-large")}
</div>

<div class="tabbable">
  <ul class="nav nav-tabs">
    <li class="active"><a href="#all" data-toggle="tab">For Everyone</a></li>
    <li><a href="#users" data-toggle="tab">For Users</a></li>
    <li><a href="#dev" data-toggle="tab">For Developers</a></li>
    <li><a href="#admin" data-toggle="tab">For Webmasters</a></li>
  </ul>
  <div class="tab-content">
    <div class="tab-pane active" id="all">
      <h2>Jonathan's ID Server is Simple.</h2>

      <p>You don't have to be a crypto genius to see how it works. Click on
      one of the tabs above to learn more.</p>
    </div>
    <div class="tab-pane" id="users">
      <h2>ID designed to keep you safe.</h2>

      <p>You only need to remember the ID you use with your ID server for all
      of the different services you use across the web. You never share that
      ID with anyone, not even your most trusted friends.</p>

      <p>When you want to use another service on the internet, your ID server
      will generate a unique ID that only that server will know about, along
      with a throwaway password for maximum security. The 3rd Party services
      on the internet won't be able to track you across services, since every
      service is given a different ID. Only the ID server knows about you.</p>

      <p>You don't share any personal information with anyone. If they want to
      know your name or phone number, they have to ask the ID server, which is
      designed to serve your needs and keep your information safe.</p>

      <p>If you want to, you can generate multiple identities on each 3rd
      Party service. The ID server will keep track of that for you. You can be
      sure never to mix your work and life personas with each other.</p>
    </div>
    <div class="tab-pane" id="dev">
      <h2>ID that's easy to develop against.</h2>

      <p>Say good bye to storing passwords and emails! You'll no longer have
      to, because the ID servers will give you a unique ID to identify your
      users with.</p>

      <p>Everytime they login, they'll give you their unique ID URL and a
      throwaway password. You can verify they are who they say they are by
      asking their ID URL to verify the password. If it checks out, you know
      they aren't trying to pretend to be someone they're not.</p>

      <p>If you want some more details about the user, you'll ask the ID
      server, which will keep you updated when that information changes.</p>

      <p>When you want to contact the user, simply send a message to the ID
      they gave you with the simple messaging interface or email. You'll know
      that that message will get forwarded to them at their most current
      address.</p>
    </div>
    <div class="tab-pane" id="admin">
      <h2>Keeping your users secure.</h2>

      <p>When users use the ID server, they learn not to share their private
      information with anyone. The ID server is what will communicate to 3rd
      Party services which details you and your users agree are
      appropriate.</p>

      <p>You can control which 3rd Party services your users are allowed to
      authenticate with. If a 3rd Party service becomes untrustworthy, you can
      shut down access to it.</p>
    </div>
  </div>
</div>
