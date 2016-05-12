# APIs & Doc

## Support Documentation

|||||
|----|---|---|---|
|[Overview](index.md) | [Accounts Service](account-toc.md) | [Query Service](query-toc.md) | [Onboarding Service](onboard-toc.md) | [Authentication Service](auth-toc.md)

### Getting started with OPP

OPP is a microservice archictecture platform. The core microservices
that offer public APIs are the **Onboarding** and **Query** services
that enable application clients to onboard metadata assets to an OPP
repository, link assets to offers, and query an OPP repository for
**assets**, **licensors** and **offers**.

The **Authentication** service allows registered client services to
authenticate and request tokens to authorise platform access,
following an OAuth 2.0 flow.

[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md#services-summary)
provides a list of the platform microservices, public APIs, and their
authentication requirements.

An OPP repository is a triplestore that stores linked data, and uses
an RDF ontology, the **Open Licensing** model, to build and interpret
the linked structures.

#### Concepts and terminology

At heart OPP is a simple mapping service that can be used to:

+ Generate identifiers for assets
+ Query on identifiers to retrieve assets and licensing data about
  them

The following terminology will help you understand the concepts around
which OPP is designed:

+ Hub Key &mdash;
+ Asset &mdash;
+ Offer &mdash;
+ Agreement &mdash;
+ Open Licensing &mdash;

Because OPP and Open Licensing are open source, you can customise the
OPP data model by extending it to include additional concepts. In
fact, you can plug in a completely different model if you want to
specialise OPP for some other knowledge domain.

### Hands on

To get a feel for how OPP works, the following sections demonstrate
the basic public APIs.

>**Note:** that because the first live platform powered by OPP is the
>[Copyright Hub](http://www.copyrighthub.org/copyrighthub_org/community/),
>all code examples in this documentation refer to the
>`copyrighthub.org` endpoints. Substitute appropriate endpoints if you
>are integrating with a different OPP instance.

#### Query an asset

To see how queries work, you just need a command line and cURL, or
other language of your choice that allows you to fire an HTTP request
from the command line. See the Query How to for a code example you can
snip. Querying for the following asset (which is preloaded as an
example as part of the platform deployment) should always return valid
data if your code is correct.

You can query for:

+
+
+

See rge how to and API ref for dteails.

Onboard an asset

OPP APIs required authenticated access, with the exception that the
Query service also accepts unauthenticated calls.

To try out the onboarding service, follow the steps in Accounts how to
to register with the OPP hub. It's straihghtforward, just respond to
the automated reply and you're set.

Then log in, create a test service, create a terst repository, and
snip the code in the How to onboard to onboard an asset. Once you've
onboared an asset, you can query for it.

Unbless you link the asset to an offer (which you can do when you
first onboard or by re-onboarding with an offer ID), your query won't
return offer information.

You can try onboarding with a generic Creative Commans offer, using
the offer ID XX.

## Contribute, extend, or deploy

OPP is an open source project.

Youi can find the code in GitHub at XX

### Contributors devs

We welcome contributions from developers who want to extend, improve,
optimise, or add to the code base.

A word about policy.

### Clients dev

If you want tp engage with an existing OPP platform instance, for
example the copyright hub, you can use the APIs to write client
appliactions that allow users to onboard and query assets and offers.

Check ouyt some of the existing copyright hub clisnts to see what's
possible.

### Deploy devs

We publish redy-to-deploy images you can use to spin up your own
hub. You can use OPP to create your own service, for piblic or
internal organisational use.

Current;y we support the following platforms:

X
B
A

## Enjoy

XX












You can find a running instance of OPP at copyrighthub, a copyright
works exchange for the UK powered by OPP. If you want to know more
about the copyright hub, read Y.  Currently, live services

For developers wanting to write application clients that integrate
with OPP services, a live instance of the OPP platform powers the
[Open Permissions Platform](http://www.openpermissions.org) and serves as a testbed
for application and service developers and for third-party engagement.


example the copyright hub, you can use the APIs to write client
you can 


The OPP offers public APIs that enable application clients to onboard
metadata **assets** to an OPP platform instance and to query against
those assets for licensing information including **licensors** and
**offers**.


API who want to
engage with an existing OPP platform instance, for example the
copyright hub, you can use the APIs to write client appliactions that
allow users to onboard and query assets and offers.

Check ouyt some of the existing copyright hub clisnts to see what's
possible.




our "hub in a box" releases provide pre-baked
ready-to-deploy platform images.




You can find 

### Clients dev


### Deploy devs


Current;y we support the following platforms:

X
B
A



If you are a developer


### Overview




These notes aim to get you up and
running quickly with the OPP public APIs.  The Open Permissions
Platform (OPP) is now available to developers as an open source
project.




For developers wanting to write application clients that integrate
with OPP services, a live instance of the OPP platform powers the
[Open Permissions Platform](http://www.openpermissions.org) and serves as a testbed
for application and service developers and for third-party engagement.

The following topics document the OPP public APIs and provide other
useful information.
