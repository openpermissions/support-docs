# APIs & Doc

## Support Documentation

||||||
|----|---|---|---|---|
|[Overview](index.md) | [Accounts Service](account-toc.md) | [Query Service](query-toc.md) | [Onboarding Service](onboard-toc.md) | [Authentication Service](auth-toc.md) |

### Getting started with OPP

OPP has a microservice architecture. Public APIs to the
[**Onboarding**](onboard-toc.md) and [**Query**](query-toc.md)
services enable application clients and external services to onboard metadata **assets** to an OPP
**repository**, link assets to **offers**, and query an OPP repository
for assets, offers, and **licensors**.

An OPP repository is a triplestore that stores linked data, and uses
an RDF ontology, the OPP **Open Licensing** profile extension to the
W3C [ODRL](https://www.w3.org/community/odrl/) Version 2.1 Core Model
policy language, to build and interpret the linked structures. The
**Repository Service** does expose public APIs, but is typically
accessed via the **Onboarding** and **Query** services.

The [**Authentication**](auth-toc.md) service allows registered client
services to authenticate and request tokens to authorise platform
access, following an OAuth 2.0 flow.

[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md#services-summary)
lists the platform microservices, public APIs, and their
authentication requirements.

All APIs, public and internal, are RESTful.

#### Concepts and terminology

At heart OPP is a simple mapping service that is used to:

+ Onboard assets and generate unique identifiers for each asset
  onboarded
+ Query on identifiers to retrieve assets and licensing data about
  them

Because the mapping is dynamically built and queried using RDF
semantic data techniques, interpreted by an open ontology, the
platform is highly flexible, configurable, and adaptable.

The following terminology will help you understand the concepts around
which OPP is designed:

+ Hub Key &mdash;
+ Asset &mdash;
+ Offer &mdash;
+ Agreement &mdash;
+ Licensor &mdash;
+ Open Licensing &mdash;

Because both OPP and the Open Permision ODRL extension are open source, you
can customise the OPP data model to extend the base concepts. Essentially,
you can plug in a different profile if you want to specialise
OPP for some other knowledge domain.

### Hands on with the APIs

To get a feel for how OPP works, the following sections demonstrate
the basic public APIs.

>**Note:** Because the first live platform powered by OPP is the
>[Copyright Hub](http://www.copyrighthub.org/copyrighthub_org/community/),
>all code examples in this documentation refer to the
>`copyrighthub.org` endpoints. Substitute appropriate endpoints if you
>are integrating with a different OPP instance.

#### Query an asset

To see how queries work, you just need a command line and cURL, or
other language of your choice that allows you to fire an HTTP request
from the command line.

Copy the *Query for asset by Hub Key*
[one line code snip](https://github.com/openpermissions/query-srv/blob/master/documents/markdown/how-to-query.md#query-for-asset-by-hub-key)
from *How to use the Query Service*, paste into a command line
console, and execute.

Asset data is returned for the asset identified by the example Hub
Key:

`https://openpermissions.org/s1/hub1/80defa84505f48108858ab653d00aa2f/asset/6732a947b42e43efab8561a856f3352a`

You can also simply paste the Hub Key into a browser navigation bar;
the asset data will be returned, assuming the asset has been onboarded
to the OPP platform identified by the Hub Key (in this case `hub1`, a
hub that integrates with the live Copyright Hub service).

Because the **Query Service** accepts unauthenticated requests, the
code needed to call its REST API is extremely simple. See the full
examples in the
[How to](https://github.com/openpermissions/query-srv/blob/master/documents/markdown/how-to-query.md#query-examples).

For details of other **Query Service** endpoints, see the
[API reference](https://github.com/openpermissions/query-srv/blob/master/documents/apiary/api.md).

#### Onboard an asset

Onboarding requires a bit more setting up. Because the **Onboarding
Service** requires authentication, to call its endpoints you must
first register with the OPP instance. Registration is simple, and
acceptance is automatic, but it involves a few steps:
  1. Register as a **user** to acquire user credentials (name and
    password)
  1. Login with your new account and create or join an **organisation**
  1. Create a **service** owned by the organisation, the service is
     assigned **client id** and **secret** credentials on creation
  1. Create a **repository** for the service, the service is
     assigned a **repository id** on creation

See
[How to create and manage accounts, services, and users](https://github.com/openpermissions/accounts-srv/blob/master/documents/markdown/how-to-register.md)
for a step by step guide.

When you've successfully registered, you can onboard assets to your
new repository.

An **asset** is just some metadata in an appropriate format, for
example the following Python string defines an asset using a CSV
header row and a single line of data:

```python
csv_data = 'source_id_types,source_ids,offer_ids,description\nexamplecopictureid,DSC_00A987,,"Cannubi cru vineyard at sunset, Barolo, Piemonte, Italy"'
```

Each additional row of data defines a new asset.

To onboard this data, your code needs to do two things:

1. Request an OAuth **access token** from the **Authentication
   Service**, supplying your service **client id** and **secret**
2. Call the **Onboarding Service** `assets` endpoint, specifying the
**repository id** in the URL, supplying the **access token** as
`Bearer` in the HTTP `post` authorization header, and the **asset**
data in the `post` body

All told, in Python for example it's less than a dozen lines of
code. You can copy and paste the code example from
[How to use the Onboarding Service](https://github.com/openpermissions/onboarding-srv/blob/master/documents/markdown/how-to-onboard.md#python-onboarding-example),
which should work out of the box.

When you query an asset you have onboarded, your query won't return
offer information unless you link the asset to an offer, either when
you first onboard, or by re-onboarding the asset with an offer
ID. Supply `offer_ids` in the appropriate CSV field (or JSON
equivalent, if you onboard as JSON).

You can use the **offer configurator** tool from the **Accounts
Service** web UI to create a minimal offer and save it into your
repository. Onboard an asset with the offer id, and then query on the
asset id to see how the offer is returned. See the
[Accounts Service guide](https://github.com/openpermissions/accounts-srv/blob/master/documents/markdown/how-to-register.md#managing-offers)
for a step by step guide to creating a minimal offer.

Each **Onboarding Service** call should pair a token request to the
**Authentication Service** with a call to an Onboarding endpoint,
supplying the new access token. This ensures that your code will not
fail because a token expires during a long transaction. See the
[How to](https://github.com/openpermissions/onboarding-srv/blob/master/documents/markdown/how-to-onboard.md)
for more details.

For other **Onboarding Service** endpoints, see the
[API reference](https://github.com/openpermissions/onboarding-srv/blob/master/documents/apiary/api.md).

### Application client development

If you want to engage with an existing OPP platform instance, for
example the [Copyright Hub](http://www.copyrighthub.org), the
[previous section](#hands-on-with-the-apis) will have given you a feel for
how to use the APIs.

You can also take a look at some of the Copyright Hub partner and
client services, listed on their
[developer portal](http://developer.copyrighthub.org/), to get a feel
for what's possible with OPP.

For example, the Copyright Hub demo service implements right/left
click on displayed images to retrieve offers from Hub Keys or image
identifiers and enable shopping cart purchases of images with just a
few clicks from finding an image to acquiring a licence for use.

## Contribute, extend, or deploy

OPP is an open source project. You can find the code in GitHub at [`https://github.com/openpermissions/`](https://github.com/openpermissions/).

The repositories are organised one for each microservice or library,
where **services** are implemented as servers and named with the
`-srv` postfix, and **libraries** have fish names. Additional
repositories contain miscellaneous UI or client code, test code, model
definitions, and documentation.

You are invited to browse, fork, and experiment.

Pull requests from forks will be reviewed by the OPP engineering team,
and we look forward to receiving your contributions.

There are no restrictions on usage, other than those specified in the
licences you can find in the repositories.

### Deploying OPP

We release ready-to-deploy "hub-in-a-box" images that you can use to
spin up your own OPP instance and run your own services or complete
platform for public or internal organisational use.

Currently we support Amazon AWS images.

<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
