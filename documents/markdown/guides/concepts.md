<!--
(C) Copyright Open Permissions Platform Coalition 2016
 -->

# Open Permissions Platform concepts and terminology

## Contents

+ [About this document](#about-this-document)
+ [Platform overview](#platform-overview)
+ [Terminology](#terminology)

## About this document

This document explains the terminology and concepts around which the
Open Permissions Platform (OPP) is designed.

For issues and support, contact
[support@openpermissions.org](mailto:support@openpermissions.org)
by email.

### See also

+ [Getting started](#getting-started) is the recommended starting
point for developers who are new to the Open Permissions Platform

## Platform overview

The Open Permissions Platform is a web based service with a
[microservice]() architecture. Microservice architecture is a
well-known software pattern, for example see the article at
[martinfowler.com](http://martinfowler.com/articles/microservices.html).

Each OPP microservice supports a single RESTful API endpoint. All
communication between OPP microservices is via their public APIs. OPP
microservices do not share state and in principle are not dependent on
each other. However, because services are collaborative, an individual
service may not be able to complete a specific client request if
another service it collaborates with is not running.

OPP's primary client functions are to:

+ Generate and return [Hub Keys]() from [entity]() data supplied by
external application clients to the [Onboarding Service]()
+ Return data requested by client calls to the [Query Service]()

Hub Keys serve as smart identifiers which encode an entity's type,
[repository]() location, and other information, and can be resolved by
the [Resolution Service]() to an individual web URI.

Hub Keys can also be used as keys by the Query Service to query
for data linked to an entity.

OPP supports a small number of entity types, including [assets](),
[offers](), and [agreements](). Details of supported entity types and
Hub Key structure can be found in the latest version of the
[Hub Key Technical Specification](../arch/TECHSPEC_V1.md).

[Onboarded]() data is built and stored in a triplestore as
[linked data]() within an OPP repository managed by the Repository
Service on behalf of each external service.

With a few exceptions API calls must be authenticated, using OAuth 2.0
[client credentials]() which are provided to external services by the
[Accounts Service]() when a new service is registered. Authorisation
and authentication are managed by the [Auth Service]().

Additional microservices and libraries provide supporting
functionality.

OPP can be downloaded as source code from the
[GitHub repositories](https://github.com/openpermissions/), or as an
Amazon AWS image from which a [hub-in-a-box]() can be spun up with all
services running on a single server instance.

The rest of this document explains the most important terminology used
in the OPP, organised alphabetically by term.

## Terminology



####

####

#### agreement

An offer agreed between a licensor and a user.

#### Accounts Service

Provides the glue between exernal services and their repos inside OPP,
supports creating offers using the model concepts, and allows external
parties to create the credentials needed to access the platform via
the Auth service.

#### Auth Service

Manages authorisation and authentication to protect an OPP instance
from unauthorised access. The [Auth Service](auth-toc.md) provides the
endpoint that enables client services to authenticate and request
tokens to authorise platform access, following an OAuth 2.0 flow.

#### asset

An [entity]() having potentially licenceable content. Assets are
[onboarded]() to OPP by external application clients and
services. Note that **assets** in this context consist of metadata
that identifies content, and not the content itself. For example when
a picture library service [onboards]() an asset it uploads metadata
and identifiers that identify a picture held in its library; the
picture image file itself is not uploaded.

#### access token

An OAuth 2.0 **access token** must be supplied to authorise access to
an authenticated OPP API.

#### bass

OPP libraries have fish names. This is a Python library used for
creating unique hub keys used within the Open Permissions Platform.

#### chub

OPP libraries have fish names. Open Permissions Platform - Python
Client An asynchronous client api to interface with the Open
Permissions Platform RESTful services

#### client ID

#### client secret

### data model, see ontology

#### entity


#### external service

An external service is either an application client or an external OPP
instance or part-instance, for example a standalone external
Repository microservice, that calls OPP endpoints.

#### federated search

OPP abstracts the complexity of working with multiple [hubs]() and/or
multiple [Repository Service]() instances and enables application
clients and external services to work with a single [Query Service]()
endpoint. Behind the scenes OPP periodically updates the
[Index Service]() with details of which repositories store which
assets. The [Query Service]() makes queries via the Index Service to
locate a given asset that may have been onboarded to one or more of
multiple repositories.

#### hub, hub-in-a-box

A **hub** is an OPP instance, specifically one that runs the complete
platform and manages repositories. **Hub-in-a-box** is a ready to run
server image from which a **hub** can be spun up running on a single
virtual server. This is in contrast to a **hub** in which each
[microservice]() runs on its own dedicated virtual server.


#### Hub Key

A uniform resource locator generated by the Open Permissions Platform
to locate an entity. Hub Keys can be thought of as smart URLs that
encode details about an entity, and which the OPP Resolution Service
is able to resolve to a specific web URL.

#### identifier, ID

OPP recognises a number of different identifiers, see the
[Hub Key Technical Specification](../arch/TECHSPEC_V1.md) for details.

#### Identity Service

Uses and various libs.

#### Index Service

Supports a periodically updated index that identifies which
repositories contain a given entity, e.g. a specific asset.

#### Koi

OPP libraries have fish names. A library used in Open Permissions
Platform services providing helpers and utilities for tornado
applications


#### licensor

A party that has the right to offer an asset.

#### licensor

A licensor is a party that offers to license an asset, specifically
anyone who creates an offer for an asset that has been onboarded to an
OPP instance.


#### microservice

OPP has a microservice architecture; each OPP endpoint is encapsulated
by an independently deployable web service. All communication between
microservices is via their publicly defined APIs. OPP microservices
collaborate to provide the end-to-end flow that supports application
clients. Because microservices are independently deployable, deployers
can choose to run partial services, for example a standalone
Repository service that connects to an external OPP instance, as an
alternative to spinning up a complete OPP platform instance. See the
[martinfowler.com](http://martinfowler.com/articles/microservices.html)
article for a summary of microservice principles.

#### OAuth

OAuth 2.0.

#### offer

Permissions of use offered for an asset.

Offers are terms under which a licensor is willing to make an asset
available to would-be users. Offers are identified by Hub Keys.

#### Open Permissions Profile

The [ODRL]() profile used by the Open Permissions Platform.


#### Open Permissions

The name of the platform.

#### Open Permissions ODRL


#### `offer_ids`

UID that identifies an offer, supplied in the appropriate CSV field or
JSON key:value pair to link an asset to an offer during onboarding or
to update the link for a previously onboarded asset.

#### offer configurator

Tool provided by the [Accounts Service]() GUI that allows an admin to
generate and save an offer.

#### ontology

OPP uses a plugin RDF ontology as a data model for the linked data it
stores and manages. The ontology is defined by the **Open
Permissions** profile extension to the W3C
[ODRL](https://www.w3.org/community/odrl/) Version 2.1 Core Model
policy language.

#### OPP Ontology

A logically-structured data dictionary containing all the terms required to support the representation of participants’ data in the OPP Ecosystem.

The OPP ontology utilises the work of the W3C Open Digital Rights Language (ODRL) project. You can read more on ODRL here.



#### offer

An offer is a specification of the terms and conditions under which an
asset is available for use, written as an ODRL expression using terms
from the OPP data model. Offers can be created by hand (which is
complex!) and onboarded to an OPP repository using OPP services, or
alternatively can be created using the Offer Configurator tool
provided by the **Accounts Service** GUI. Offers may be custom made
for an individual service, or may be pre-defined generic offers, for
example OPP includes a generic Creative Commons licence offer.

#### Onboarding Service

** requires authentication, to call its endpoints you must

#### OPP user

  1. Register as a **user** to acquire user credentials (name and
    password)

#### organisation

1. Login with your new account and create or join an **organisation**


#### repository

An OPP repository is a storage silo that is dedicated to a single
registered external service. A repository is implemented as a
triplestore that stores linked data, and uses an RDF ontology to
build, navigate, and interpret the linked structures. Repository
services are provided by a **Repository** microservice instance, which
abstracts a potential "multi-repository" federated and distributed
implementation. Typically repositories are accessed via the
**Onboarding** and **Query** services, but the Repository API can also
be called directly. Repositories are created and managed by external
service admins using the **Accounts** service.


#### RDF

Dynamic model performs the mapping, uses cool tech, RDF and


#### repository

1. Create a **repository** for the service, the service is

#### repository id

#### SPARQL

#### service

1. Create a **service** owned by the organisation, the service is

#### Services

The OPP exposes a small number of RESTful APIs to external
clients. APIs are encapsulated as microservices. There are (at
present) Eight Core Services: Index, Onboarding, Repository,
Transformation, Resolution, Query, Auth and Accounts.

#### source ID




#### transformation

#### Transformation Service

of input output




#### ??

+ Say where the other libs fit?
+ Draw a picture!


<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
