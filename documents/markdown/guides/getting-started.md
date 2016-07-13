<!--
(C) Copyright Open Permissions Platform Coalition 2016
 -->

# Getting started with OPP

## Contents

+ [About this document](#about-this-document)
+ [Overview](#overview)
+ [OPP client workflow](#opp-client-workflow)
+ [Hands-on with the APIs](#hands-on-with-the-apis)
  + [Query an asset](#query-an-asset)
  + [Onboard an asset](#onboard-an-asset)
  [Application client development](#application-client-development)
+ [Contribute, extend, or deploy](#contribute-extend-or-deploy)
  + [Deploying OPP](#deploying-opp)

## About this document

This document is an introduction to the Open Permissions Platform
(OPP) and the OPP APIs.

For issues and support, contact
[support@openpermissions.org](mailto:support@openpermissions.org)
by email.

### See also

+ [Open Permissions Platform Concepts](concepts.md) introduces and
  defines the main concepts and terminology used in OPP

## Overview

The Open Permissions Platform (OPP) is a generic system for managing
rights licensing.

Using OPP APIs, application clients and external services can define
and link permission **offers** to **assets**, making the permissions
for asset usage easily discoverable on the web, and enabling permission
**agreements** to be made between content creators and content users.

Offers are defined using the W3C
[ODRL](https://www.w3.org/community/odrl/) policy language.

Offers, agreements, asset metadata, and the links that connect them are
stored in OPP **repositories** as linked data within a triplestore.

OPP uses an OAuth 2.0 flow to authorise and authenticate API requests.

All APIs, public and internal, are RESTful.

OPP has a microservice architecture.

The remainder of this document summarises the OPP client workflow,
with hands-on code examples showing how to **onboard** assets to an
OPP repository and **query** an OPP repository for offers using an
asset identifier.

OPP is an open source project and freely available for download and
use. Contributions from the open source development community are
encouraged.

## OPP client workflow

From the perspective of an external client, OPP provides a
straightforward workflow:

+ Onboard assets to OPP and generate unique identifiers for each asset
  onboarded
+ Generate and onboard offers to OPP and generate unique identifiers
  for each offer onboarded
+ Link assets to offers during asset onboarding or at any time later
+ Query on identifiers to retrieve assets and offers
+ Display offers to end users, and invite users to accept offer
  agreements

The identifiers that OPP generates are known as **Hub Keys**. Queries
can be made against OPP using Hub Keys or the source identifiers with
which assets were originally onboarded.

OPP stores linked data structures that are dynamically built and
queried using RDF semantic data techniques and an ontology defined in
the **Open Permissions** ODRL profile, which makes the platform highly
flexible, configurable, and adaptable.

In addition to the basic client workflow, OPP provides additional
functionality including:

+ Multiple hubs and federated repositories accessed via an **Index
  Service** to locate assets
+ Offer data transformation into valid XML format performed by the
  **Transformation Service**
+ Hub Key generation and resolution including redirecting to service
  URLs performed respectively by the **Identity Service** and
  **Resolution Service**
+ Account management performed by the **Accounts Service**
+ Client authorisation/authentication performed by the
  **Auth Service**

For more details about the individual services see the relevant [API
documentation](../tocs/index.md#services).

For a fuller discussion of OPP concepts and terminology see
[Open Permissions Platform Concepts](concepts.md).

## Hands-on with the APIs

To get a feel for how OPP works, the following sections demonstrate
the basic public APIs.

>**Note:** Because the first live platform powered by OPP is the
>[Copyright Hub](http://www.copyrighthub.org/copyrighthub_org/community/),
>all code examples in this documentation refer to the
>`copyrighthub.org` endpoints. Substitute appropriate endpoints if you
>are integrating with a different OPP instance.

### Query an asset

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

### Onboard an asset

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

1. Request an OAuth **access token** from the **Auth
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
**Auth Service** with a call to an Onboarding endpoint,
supplying the new access token. This ensures that your code will not
fail because a token expires during a long transaction. See the
[How to](https://github.com/openpermissions/onboarding-srv/blob/master/documents/markdown/how-to-onboard.md)
for more details.

For other **Onboarding Service** endpoints, see the
[API reference](https://github.com/openpermissions/onboarding-srv/blob/master/documents/apiary/api.md).

## Application client development

If you want to engage with an existing OPP platform instance, for
example the [Copyright Hub](http://www.copyrighthub.org), the
[previous section](#hands-on-with-the-apis) will have given you a feel for
how to use the APIs.

You can also take a look at
[some of the services](http://developer.openpermissions.org/) that are
already using OPP to get a feel for what's possible.

## Contribute, extend, or deploy

OPP is an open source project. You can find the code in GitHub at
[`https://github.com/openpermissions/`](https://github.com/openpermissions/).

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
