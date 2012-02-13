<%inherit file="/layout/basic.mako"/>
<h2>A Universal Online ID System</h2>

<ul>
    <li>${h.link_to('Create a new ID with us',
        url(controller='create'))}</li>
    <li>${h.link_to('Retrieve/Generate a Pseudo-ID',
        url(controller='generate'))}</li>
</ul>

<p>Welcome to Jonathan's ID Server!</p>

<p>This is an experiment that I think might make life easier for everyone
involved in the messy business of identity, authentication, and
authorization.</p>

<p>The idea is people and organizations can create ID servers like this one.
They can allow people they know, or random strangers, to create identities on
these servers. These users manage the data associated with their identity.
Then, when they want to login to a 3rd Party service, they present credentials
for a pseudo-ID from these ID servers.</p>

<p>Only the ID servers know which pseudo-IDs belong to which people. They give
different pseudo-IDs to all the different 3rd Party services, so that they
cannot collude together to figure out a bigger picture of who people really
are.</p>

<p>If they want personal information about a person using their service, they
have to go through the ID server. You won't have to tell them secrets about
your life, or even share your password with them.</p>

<p>Let's say a retailer wants to know where to ship a package. The ID service
provider could provide a generic address with forwarding instructions only the
ID service knows how to interpret. This way, the retailer will never know
where the user is actually coming from. The same can be done for phone numbers
and more.</p>

<p>Of course, there is the potential for grand abuse. This is why the ID
servers are distributed. Certain ID service operators may keep track of
information such as credit score. Others may keep track of a person's actual
national affiliation. 3rd Party servers can learn which of these ID servers
are trustworthy, and which are not. For instance, one 3rd Party service can
say, "If you don't use this ID server, we're not going to accept your
credentials." A bank or a credit card company certainly requires that they
know the person behind the id is at least worthy of some credit, and may rely
on a particular ID server, or group of servers, to keep track of the details
of the financial viability of the individual, without revealing too much to
the banks and credit card companies.</p>

<p>The end result, hopefully, is a world where everyone doesn't care who you
really are. (The vast majority of websites really don't care who you are, they
just want a unique identifier, and sometimes some details about you like your
name or favorite color.) Only the ID servers you allow yourself to associate
with really know anything about you, and the only reason you trust them is
because they keep your personal information safe and secure.</p>
