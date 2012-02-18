<%inherit file="/layout/basic.mako"/>

<h2>Overview</h2>

<p>There are three parties involved in the authentication process.</p>

<ol>
  <li>The User.</li>
  <li>The ID Service.</li>
  <li>A 3rd Party Service.</li>
</ol>

<p>Let's examine their goals.</p>

<dl>
  <dt>The User</dt>
  <dd><ul>
    <li>Wants to use a 3rd Party Service.</li>
    <li>Doesn't want them to confuse him with someone else.</li>
    <li>Doesn't want them to share information between other 3rd Party Service
    without his permission.</li>
  </ul></dd>
  <dt>The 3rd Party Service</dt>
  <dd><ul>
    <li>Wants to authenticate users accurately.</li>
    <li>Wants only the personal information it needs about the user to
    facilitate its services.</li>
    <li>May desire to gather more informaton that it needs or share it with
    other services.</li>
  </ul></dd>
</dl>

<p>Some of these goals align: both the User and the 3rd Party Service want to
authenticate properly. Some of them diverge: The User isn't as excited about
sharing his information as the 3rd Party Service is.</p>

<p>The ID Service arranges a User&ndash;3rd Party Service contact that provides
accurate authentication and limits the amount of information shared.</p>

<h2>How Authentication Works</h2>

<p>We will examine the User-3rd Party Service authentication method.</p>

<ol>
  <li>The User authenticates with his ID Server. (The methods of authentication
    are not important to the 3rd Party Service.)</li>

  <li>The 3rd Party Service declares to the user what its unique identifier
    is&mdash;a Service URL.</li>

  <li>The User sends the Service URL to the ID Service.</li>

  <li>The ID Service returns a unique ID (a User URL), along with a temporary, one-time use
    password to the user.</li>

  <li>The User sends the User URL along with the one-time use password to the
    3rd Party Service.</li>

  <li>The 3rd Party Service verifies that he User URL and password match with
    the ID Service. (The exact method is given below.)</li>

  <li>The 3rd Party Service gives a limited session cookie, or uses whatever
    method it wants to maintain a session with the user which is associated
    with the User URL.</li>

  <li>The 3rd Party Service retains the User URL indefinitely. When the same
    user returns, he will give the same User URL with a new password.</li>
</ol>

<h2>How Personal Information is Shared</h2>

<p>Users should never, ever share their personal identifying information with
3rd Party Services. Instead, the 3rd Party Services which want personal
information on its users must query the ID Service. The ID Service will store
the user's information, and share it only with those services which the user
has allowed it to. When the user updates their information, and desires the
services to know, they will be informed. In this way, the user only needs to
manage its information on the ID servers, and not with every 3rd Party Service
he uses.</p>

<p>The process is as follows.</p>

<ol>
  <li>When the 3rd Party Service verified the User URL and one-time password
    with the ID Service, it was given a Subscription URL and an Unsubscription
    URL.</li>

  <li>The 3rd Party Service subscribes to the ID Server by sending it's Update
    URL to the Subscription URL along with the information it wants to be
    updated on.</li>

  <li>The ID Service verifies with the user whether to share the information.
    The user may even decide to provide false information to the 3rd Party
    Service, which the ID Service will facilitate.</li>

  <li>If the user refuses to provide the information, the ID Service will call
    the Update URL specifying so.</li>

  <li>If the user choses to provide the information, then the ID Service will
    call the Update URL with the information requested.</li>

  <li>The ID Service may instead share incorrect information, information that
    it may be able to identify if the 3rd Party Service leaks the information
    to other 3rd Party Services. The ID Service operators, or the user, will
    be able to tell which 3rd Party Services are sharing information they
    should not be.</li>

  <li>If the user updates the information in the ID Service, and decides to
    share the update with the 3rd Party Service, then the ID Service will call
    the Update URL again.</li>

  <li>If the 3rd Party Service no longer wishes to receive updates, it can use
    the Unsubscribe URL.</li>
</ol>

<h2>User URL</h2>

<p>The User URL is unique for each User&ndash;3rd Party Service.</p> 

<p><strong>NOTE:</strong> 3rd Party Services should not share the User URL
  with any other service.</p>

<p>The 3rd Party Service can authenticate the User with a GET request to the
User URL, with the password added as the GET parameter <code>password</code>.
It must also specify an .</p>


<p>On Jonathan's ID Service, the User URL looks like:</p>

<pre>http://id.jonathangardner.net/user/<em style="color:red;">UUID</em></pre>

<p>With the password appended, it will look like:</p>

<pre>http://id.jonathangardner.net/user/<em style="color:red;">UUID</em>?password=<em style="color:red">password</em></pre>

<p>Calling that URL will get a JSON response.</p>

<h3>Authentication Response</h3>

<p>If the password is correct, then the result will be JSON with the following
keys:</p>

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>Key</th>
      <th>Type</th>
      <th>Meaning</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>success</td>
      <td>boolean</td>
      <td>Whether authentication was successful.</td>
      <td><code>"success":true</code></td>
    </tr>
    <tr>
      <td>subscribe_url</td>
      <td>string</td>
      <td>The URL to use to subscribe to personal data. Missing if the
        authentication failed.</td>
      <td><code>"subscribe_url":"http://id.jonathangardner.net/data/1234abcd/subscribe"</code></td>
    </tr>
    <tr>
      <td>unsubscribe_url</td>
      <td>string</td>
      <td>The URL to use to unsubscribe from personal data. Missing if the
        authentication failed.</td>
      <td><code>"unsubscribe_url":"http://id.jonathangardner.net/data/1234abcd/unsubscribe"</code></td>
    </tr>
  </tbody>
</table>

<h2>Subscription</h2>

<p>3rd Party Services subscribe to receive personal information about the
users.</p>

<p>The kinds of information they may obtain are unlimited. All facts are
simply given as a fact name - value pair. The value can be any valid JSON
value. All the 3rd Party Service needs to do is request a fact by its name.
The following table lists some common facts.  It is not an error to use facts
not given below.</p>

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>Fact Name</th>
      <th>Meaning</th>
      <th>Examples</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Greeting Name</td>
      <td>The name the user preferred to be greeted with.</td>
      <td>"Jonathan", "Mr. Gardner", "Dr. Smith", etc...</td>
    </tr>
    <tr>
      <td>Favorite Color</td>
      <td>The color the user prefers.</td>
      <td>"#0000ff"</td>
    </tr>
    <tr>
      <td>Mailing Address</td>
      <td>The address the User would prefer the 3rd Party Service sent its
      packages to.</td>
      <td>"PO Box 1211, Nowhere, USA"</td>
    </tr>
  </tbody>
</table>

<p>Note that the user is likely to give false information. Some ID Servers
profice mail forwarding so any mailing address provided will simply be a
forwarding address.</p>

<p>The subscription request is a request to the <code>subscribe_url</code>
returned from the User URL during authentication. The 3rd Party Service
appends to that the following GET parameters:</p>

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>Parameter</th>
      <th>Type</th>
      <th>Meaning</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>a</td>
      <td>string</td>
      <td>The attribute the 3rd Party Service wants to know. Specifying this
      multiple times is OK.</td>
      <td><code>a=First+Name&amp;a=Favorite+Color</code></td>
    </tr>
    <tr>
      <td>update_url</td>
      <td>string</td>
      <td>The URL to use to update the data.</td>
      <td><code>update_url=http://example.com/update/1234abcd"</code></td>
    </tr>
  </tbody>
</table>

<p>The service always responds with a simple <code>{"success":"true"}</code>
if everything was successfuly. There is no reason why it should fail, provided
the User URL was not invented.</p>

<p>Note that the ID Service may choose to ignore subscription requests for
whatever reason it chooses. There is no guarantee that the ID service will
respond.</p>


<h1>Development Status</h1>
<pre>
SHOULD BE WORKING:
* You can register
* You can change your password
* You can login / logout
* You can generate new ids unique to a service.

NEXT UP:
* Better documentation for clients
* Services can validate an id: yes/no
* Services can subscribe/unsubscribe to fields per user. The callback URL is
  given by the 3P Service URL.
* users can specify fields
  * text
  * images
  * etc...
* users can control which services they share which fields with, and give
  alternate answers
* When a field is specified, or modified, or permitted, then the callback is
  called.
* Complete the login loop.
  * User is given the 3P Service URL.
  * User visits ID service, gives 3P Service URL, is given an ID.
  * User visits 3P, gives ID.
  * 3P Service authenticates that it is legit with ID service.
  * 3P Service requests information about user from ID Service.
  * User is asked to share data with 3P Service by ID Service.
  * When the user permits it, the data is shared.

SHORT-TERM:
* Expiring credentials. Just knowing the pseudo ID isn't enough to login as
  the person. You also need to provide an additional auth token that expires.
* Forgot your password email.
* Example implementation: image server? address book? Online money system?

LONG-TERM:
* Multiple emails per account
* Treat IDs as an email address. That is, accept email and process
  them by forwarding them to the intended target. 
* Don't hardcode the hostname.
* Figure out friends. Can we just consider servers as an identity and
  have everything be identity-identity relationships? Is this enough to solve
  the address book problem?
* How do we handle 3rd Party Services which violate the TOS and share
  information they aren't supposed to? 

DISTANT FUTURE:
* Provide a physical mailing address, phone messaging service, etc... so that
  3rd Parties NEVER have to have any identifying information.

</pre>
