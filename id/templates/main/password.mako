<%inherit file="/layout/basic.mako"/>
<h1>We store your password securely.</h1>

<p>We use the most advanced password storage system we know. This is how it
works.</p>

<ol>
  <li><strong>Salt.</strong> We generate a large random salt each time we
  store a new password hash for you. This is to prevent someone who happens to
  obtain our database from quickly looking up your password in a rainbow
  table.</li>

  <li><strong>SHA512</strong> We store the salt and the SHA512 hash of your
  password and that salt. SHA512 is a very strong hash algorithm. It is all
  but impossible to figure out what your password was given the hash of the
  salt and the password together.</li>

  <li>We have prepared for the worst. Let's suppose the worst-case scenario
  happens: hackers steal our entire database and our entire codebase. So what?
  It will take them a very long time to crack just one password. In that time,
  we can patch up our security holes, send our a notice to all of our
  customers to reset their password, and continue with business as usual.</li>
</ol>

<h2>We need YOUR help.</h2>

<p>If you use an easy-to-guess password, then hackers will be able to figure
that out in no time flat. All they have to do is guess a few times, and
they'll be able to see that your password works. So follow these tips to
ensure that they won't be likely to guess your password quickly:</p>

<ol>
  <li>Don't use a short password. Try to use 8 or more characters.</li>

  <li>Combine upper case, lower case, numbers and symbols.</li>

  <li>Don't base your password off a word you might find in a dictionary, even
  if you think you are clever and use '0' for 'o' and '3' for 'E'. That's
  pretty easy to guess.</li>

  <li>Don't use numbers that are important to you: your birthdate, your
  wedding date, etc... You'd think that this is a relatively unique number,
  but it's not.</li>
</ol>

<p>But that's not all! You need to follow these security tips to ensure that
your password isn't stolen.</p>

<ol>
  <li>Don't write it down. If you do need to write it down, store it the same
  way you'd store the deed to your house: securely, behind lock and key.</li>

  <li>Don't use the same password for two different systems. If someone
  figures out your password in one place, you can be sure they are going to
  try the same password everywhere. We can't vouch for the way that other
  people store your password, so it's best to treat them all as if they were
  hackers too.</li>

  <li>Change your password often. We suggest once a month, but we're leaving
  that up to you. When you do change your password, don't rotate through to
  old ones.</li>
</ol>

<h2>We hate passwords too!</h2>

<p>If you're doing passwords right, you're not going to remember them. I know,
I've tried. That's why I'm creating this ID Service: it's a one-stop
authentication system that everyone on the internet can trust.</p>

<ol>
  <li>You don't have to think of secure passwords for every service you use.
  We already use them for your pseudo-ID's: They're a large string of
  completely random noise.</li>

  <li>You don't have to remember to change your passwords: Our passwords work
  once, and that's it.</li>

  <li>You only have one password to worry about: And that's the password you
  use here. Memorize it, make it as long as you wish, and change it every
  month or so.</li>
</ol>

<h2>What does the future hold?</h2>

<p>Unfortunately, passwords are here to stay. There's really no way around
them. Sure, you can carry around a key generator, or have your ID embedded in
your skin, but that's not going to solve the problem if someone steals your
key generator or somehow manages to steal the ID in your skin.</p>

<p>The safest place is in your brain, where no one can find it.</p>
