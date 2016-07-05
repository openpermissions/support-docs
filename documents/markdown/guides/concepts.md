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

+ [Getting started with OPP](#getting-started) is the recommended
starting point for developers who are new to the Open Permissions
Platform, providing a quick introduction to the OPP APIs, including
code examples

## Platform overview

The Open Permissions Platform (OPP) is a web based service with a
[microservice](#microservice) architecture. Microservice architecture
is a well-known software pattern, for example see the article at
[martinfowler.com](http://martinfowler.com/articles/microservices.html).

Each OPP microservice supports a single RESTful API endpoint. All
communication between OPP microservices is via their public APIs. OPP
microservices do not share state and in principle are not dependent on
each other. However, because services are collaborative, an individual
service may not be able to complete a specific client request if
another service it collaborates with is not running.

OPP's primary client functions are to:

+ [Onboard](#onboard) data from
  [external services](#external-services) including application
  clients
+ Generate and return [Hub Keys](#hub-key) that uniquely identify
  onboarded [entities](#entity)
+ Return query results to application clients, keyed on various types
  of entity [identifiers](#identifier-id) including Hub Keys

Other [OPP services](#opp-services) and a small number of libraries
provide supporting functionality.

Hub Keys serve as smart identifiers which encode an entity's type,
[repository](#repository) location, and other information. Hub Keys
are also true URLs that can be resolved or redirected by the
[Resolution Service](#resolution-service) to an individual web URI.

OPP supports a small number of entity types, including
[assets](#asset), [offers](#offer), and
[agreements](#agreement). Details of supported entity types and Hub
Key structure can be found in the latest version of the
[Hub Key Technical Specification](../arch/TECHSPEC_V1.md).

[Onboarded](#onboard) data is built and stored in a triplestore as
[linked data](#linked-data) within OPP repositories, which are managed by the
[Repository Service](#repository-service) on behalf of external
services.

With a few exceptions API calls must be authenticated, using
[OAuth 2.0](#oauth)
[client credentials](#client-credentials-see-client-id-and-client-secret)
which are generated for [external services](#external-service) by the
[Accounts Service](#accounts-service) when a new service is
registered. Authorisation and authentication are managed by the
[Auth Service](#auth-service).

OPP can be downloaded as source code from the
[GitHub repositories](https://github.com/openpermissions/), or as an
Amazon AWS image from which a [hub-in-a-box](#hub-hub-in-a-box) can be
spun up with all services running on a single server instance.

The rest of this document explains the most important terminology used
in the OPP, organised alphabetically by term.

## Terminology

#### access token

An [OAuth 2.0](#oauth) access token must be supplied to authorise
access to an authenticated OPP API. For details see
[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md).

#### Accounts Service

Provides a service API as well as a browser-based GUI to support
account creation and settings management for
[external services](#external-service) and application clients built
on top of OPP. For details see the
[Accounts Service](../tocs/account-toc.md) API documentation, and
[How to create and manage accounts, services, and users]
(https://github.com/openpermissions/accounts-srv/blob/master/documents/markdown/how-to-register.md).

#### agreement

An offer agreed between a [licensor](#licensor) and a user. Agreements are
identified by OPP-generated UUIDs.

#### asset

An [entity](#entity) having potentially licenceable content. Assets
are [onboarded](#onboard) to OPP by
[external services](#external-service) and application clients. Note
that OPP does not onboard content. When an asset is onboarded, data
*about* the asset is onboarded, but not the asset content. For example
when a picture library service onboards an asset it uploads metadata
and [identifiers](#identifier-id) that identify a picture held in its
library; the picture image file itself is not uploaded.

#### Auth Service

Manages authorisation and authentication to protect an OPP instance
from unauthorised access. The [Auth Service](../tocs/auth-toc.md)
provides the endpoint that enables client services to authenticate and
request tokens to authorise platform access, following an
[OAuth 2.0](#oauth) flow.

#### Bass

OPP libraries have fish names. This is a Python library used for
creating unique [Hub Keys](#hub-key) used within the OPP.
 
#### Chub

OPP libraries have fish names. This library defines an asynchronous
Python client API to interface with the OPP RESTful services.

#### client credentials, see [client ID](#client-id) and [client secret](#client-secret)

#### client ID

ID component of client credentials used by an
[external service](#external-service) to authenticate with an OPP
instance. See [OAuth](#oauth).

#### client secret

"Secret" component of client credentials used by an
[external service](#external-service) to authenticate with an OPP
instance. See [OAuth](#oauth).

#### data model, see [ontology](#ontology)

#### entity

Entities are the metadata objects that are [onboarded](#onboard) to
OPP, for example [assets](#asset), [offers](#offer), or
[agreements](#agreement). An entity in OPP is always an instance of a
supported entity type. Details of supported entity types and
[Hub Key](#hub-key) structure can be found in the latest version of
the [Hub Key Technical Specification](../arch/TECHSPEC_V1.md).

#### external service

An external service is typically an application client or an external
OPP instance, or a standalone OPP service for example an external
[Repository Service](#repository-service), that calls OPP endpoints.

#### federated search

OPP abstracts the complexity of working with multiple
[hubs](#hub-hub-in-a-box) and/or multiple
[Repository Service](#repository-service) instances and enables
application clients and [external services](#external-service) to work
with a single [Query Service](#query-Service) endpoint. Behind the
scenes OPP periodically updates the [Index Service](#index-service)
with details of which repositories store which assets. The
[Query Service](#query-Service) makes queries via the Index Service to
locate a given asset that may have been [onboarded](#onboard) to one
or more of multiple repositories.

#### hub, hub-in-a-box

A hub is an OPP instance, specifically an instance that runs the
complete platform and manages
[repositories](#repository). "Hub-in-a-box" is a ready to run server
image from which a hub can be spun up running on a single virtual
server. This is in contrast to a hub in which each
[microservice](#microservice) runs on its own dedicated virtual
server.

#### Hub Key

A uniform resource locator generated by the OPP to locate an
[entity](#entity). Hub Keys can be thought of as smart URLs that
encode details about an entity, and which the OPP
[Resolution Service](#resolution-service) is able to resolve to a
specific web URL.

#### identifier, ID

OPP recognises a number of different identifiers, see the
[Hub Key Technical Specification](../arch/TECHSPEC_V1.md) for details.

#### Identity Service

Generates [Hub Keys](#hub-key), supported by the [Bass](#bass)
library. See the [Identity Service](../tocs/identity-toc) API
documentation.

#### Index Service

Routing service that tracks which assets have been
[onboarded](#onboard) to which [repositories](#repository), and that
maintains a cached index for quick retrieval. See the
[Index Service](../tocs/index-toc) API documentation.

#### Koi

OPP libraries have fish names. This a Python library that provides
helpers and utilities for Tornado applications.

#### licensor

A party that has the right to offer an asset.

#### linked data

Data stored in a graph data model format as RDF triples. For more
about graph data and RDF see the
[Wikipedia article](https://en.wikipedia.org/wiki/Resource_Description_Framework),
which includes comprehensive references. RDF is a W3C standard.

#### microservice

OPP has a microservice architecture; each OPP endpoint is encapsulated
by an independently deployable web service. All communication between
microservices is via their publicly defined APIs. OPP microservices
collaborate to provide the end-to-end flow that supports application
clients. Because microservices are independently deployable, deployers
can choose to run partial services, for example a standalone
[Repository Service](#repository-service) that connects to an external
OPP instance, as an alternative to spinning up a complete OPP platform
instance. See the
[martinfowler.com](http://martinfowler.com/articles/microservices.html)
article for a summary of microservice principles.

#### OAuth

OPP uses an [OAuth 2.0](http://oauth.net/2/) authentication flow. For
details see
[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md)
and the [Auth Service](../tocs/auth-toc.md) API documentation.

#### offer

An offer is a specification of the terms and conditions under which an
[asset](#asset) is available for use, written as an ODRL expression
using terms from the OPP [data model](#data-model). Offers are
identified by OPP generated UUIDs.

Offers can be created by hand (which is complex!) and
[onboarded](#onboard) to an OPP [repository](#repository) using OPP
services, or alternatively can be created using the
[Offer Configurator](#offer-configurator) tool provided by the
[Accounts Service](#accounts-service) GUI. Offers may be custom made
for an individual [external service](#external-service), or may be
pre-defined generic offers, for example OPP includes a generic
Creative Commons licence offer.

#### Offer Configurator

Tool provided by the [Accounts Service](#accounts-service) GUI that
allows an admin to generate and save an [offer](#offer).

#### ontology

OPP uses a plugin RDF ontology as a data model for the
[linked data](#linked-data) it stores and manages. The ontology is
defined by the Open Permissions Profile extension to the W3C
[ODRL](https://www.w3.org/community/odrl/) Version 2.1 Core Model
policy language.

#### onboard

Upload [entities](#entity) of recognised types to the OPP using the
[Onboarding Service](#onboarding-service) APIs, and by doing so bring
data into the OPP ecosystem.

#### Onboarding Service

Enables software clients to onboard i.e. upload entity data to
OPP. See
[How to use the Onboarding Service](https://github.com/openpermissions/onboarding-srv/blob/master/documents/markdown/how-to-onboard.md)
and the [Onboarding Service](../tocs/onboard-toc) API documentation.

#### Open Permissions Profile, see [ontology](#ontology)

#### OPP services

The OPP exposes a small number of RESTful APIs to external
clients. APIs are encapsulated as
[microservices](#microservice). There are (at present) eight core
services: [Index](#index-service), [Onboarding](#onboarding-service),
[Repository](#repository-service),
[Transformation](#transformation-service),
[Resolution](#resolution-service), [Query](#query-service),
[Auth](#auth-service) and [Accounts](#accounts-service).

#### organisation

OPP accounts are administered by individual admin users on behalf of
organisations. [External services](#external-service), i.e. software
clients that call OPP API endpoints, are always created and managed
within an Organisation account.

#### Query Service

Supports querying an OPP instance for licensing data stored in
repositories, including
[federated repositories](#federated-search). See
[How to use the Query Service](https://github.com/openpermissions/query-srv/blob/master/documents/markdown/how-to-query.md)
and the [Query Service](../tocs/query-toc) API documentation.

#### Resolution Service

Resolves OPP IDs. See the [Resolution Service](../tocs/resolution-toc)
API documentation.

#### repository

An OPP repository is a storage silo that is dedicated to a single
registered [external service](#external-service) or application
client. A repository is implemented as a triplestore that stores
[linked data](#linked-data), and uses an RDF [ontology](#ontology) to
build, navigate, and interpret the linked structures. Repositories are
managed by the [Repository Service](#repository-service), and
typically are accessed via the [Onboarding](#onboard) and
[Query](#query) services, but the Repository Service API can also be
called directly. Repositories are created by external service admins
using the [Accounts Service](#accounts-service).

#### Repository Service

Supports storage and retrieval of [onboarded](#onboard) data, with a
multi-tenant facility that stores each software client's data in
dedicated repositories which have their own access control policy. See
the [Repository Service](../tocs/repository-toc) API documentation.

#### Transformation Service

Transforms rights data expressed in non-XML RDF formats into valid
XML. See the [Transformation Service](../tocs/transformation-toc) API
documentation.

<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

