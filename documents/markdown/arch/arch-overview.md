# Open Permissions Platform High Level Overview

## Contents

+ [About this document](#about-this-document)
+ [Introduction](#introduction)
+ [Architecture principles](#architecture-principles)
+ [Authentication](#authentication)
+ [Operational decomposition](#operational-decomposition)
+ [Data principles of the Open Permissions Platform](#data-principles-of-the-open-permissions-platform)
+ [Security principles](#security-principles)


## About this document

This document provides a high level overview of the Open Permissions Platform, including system features and design principles. It is intended to provide basic orientation and context for those new to the project, as well as a first introduction for technical audiences.

For information, issues, and support, contact [support@openpermissions.org](mailto:support@openpermissions.org) by email.

### See also

+ [Link TBD, The Blueprint]
+ [Link TBD, HLD]

---

## Introduction

The Open Permissions Platform is a reference implementation of an online rights exchange platform. The platform makes available public APIs for:

+ Uploading rights data about *creations* (i.e. copyright works)
+ Discovery of rights-related data including available *rights offers* for creations

The Open Permissions Platform aims to provide a foundation for third party applications and services, including one-click e-commerce services, intended to streamline rights exchange for copyright works of all kinds.

The Open Permissions Platform aspires to a global audience. Its design assumes a highly distributed service federated over multiple instances of repository and registry services, against which any third party can create client applications, from web browser plugins and dedicated social network plugin apps, to custom mobile and desktop clients.

The current version of the platform supports use cases for **digital images** with a restricted set of simplified standard rights.

Future releases will add support for additional creation types, and allow more complex rights to be expressed. See the [LINK TBD roadmap] for more details.

### Collaborators

+ The Open Permissions Platform implementation is being developed by the Open Permissions Platform Coalition.

## Architecture principles

The system design follows a Service-Oriented Architecture approach, with all services implemented as microservices. Services expose RESTful APIs internally to other services, and externally to client applications.

Both the Micro Service Architecture (MSA) and REST API implementation add a degree of design and development overhead. MSA requires a greater number of individual services to be developed, tested, and released at final product quality. REST removes complexity for clients, but can be marginally more complex to design and implement.

However, both also contribute to more robust, scalable, and effective systems and services.

### Service-Oriented Architecture (SOA)

A Service-Oriented Architecture (SOA) divides system functionality between distinct software applications, each of which is implemented as a service responsible for a well defined functional subset of the system. All services communicate via external APIs, and in effect appear as black boxes to other services. Services are therefore loosely coupled, and run independently of each other. Logical dependencies between services are limited to dependence on one or more other services being available, which is verified at runtime.

###  Micro Service Architecture (MSA)

Individually, services follow a Micro Service Architecture (MSA). Each microservice is responsible for a small subset of logically related operations, typically encapsulated behind a single API.

Advantages of the microservice approach include:

+ Each service is simple and focuses on doing one thing well
+ Each service is built using the best technologies for the job
+ Micro services are inherently loosely coupled
+ Supports incremental, scalable development
+ Supports scalable and distributed deployment

MSA encourages a lightweight, modern, distributed, and extensible design approach.

### RESTful APIs with common usage conventions

All Open Permissions Platform microservice APIs are implemented as RESTful APIs. REST is a well known and common design pattern for web-based services. API endpoint query URLs identify resources on which a standard set of operations are supported -- Create, Read, Update, Delete, List (often referred to as CRUDL operations).

REST encourages clean, well-structured, and uncluttered API design, and leads to APIs that are more intuitive for client application developers to discover and understand. They also work well with the strongly decoupled microservices approach.

All Open Permissions Platform service APIs follow common conventions for querying and uploading data. For example, all API queries return data in JSON format; and all APIs that accept data accept JSON.

### JSON data

JSON has become the de facto data standard for web services, and is both platform and programming language agnostic. Because JSON is a string representation it is immune to platform hardware differences (for example, big-endian/little-endian systems), and is well supported by all popular programming languages for desktop and mobile web clients.

## Authentication

The Open Permissions Platform is an authenticated service. Although the software is being developed as an open source project -- all software will be freely downloadable from open GitHub repositories -- all services implement mutual SSL authentication. Client applications and services must therefore authenticate with SSL certificates in order to gain access.

The following categories of user require authentication to use the service:

+ Content creators -- represented by agent organisations e.g. a picture library, an individual publisher, a broadcaster, a Hollywood movie studio, a two-person indie games studio
  + Register as party organisations
+ Rights holders -- any of the above, as well as individual end users who have acquired rights via client application software
  + Register as party organisations
  + Unregistered end-users accessing via registered applications
+ Applications and services -- third party software using Open Permissions Platform services via public APIs
  + Register as Services

## Operational decomposition

The Open Permissions Platform services are grouped into three operational areas:

### Registry Operations

#### Accounts

##### GitHub repo:

https://github.com/openpermissions/accounts-srv

This provides party accounts, and against a party account can be registered services, such as rights repositories.  Some of the information held here would be publicly available, as it will be required in order to know who owns and manages various services. This service will provide a minimal UI for account management.

#### Authentication

##### GitHub repo:

https://github.com/openpermissions/auth-srv

The Open Permissions Platform requires parties to be registered participants in order to operate and interact with services. Additionally each service can specify authorisation rules in regards to its APIs. The Authorisation Service is responsible for authenticating and authorisation across the Open Permissions Platform.

#### Registration

**NOTE**: In the **current release** this is renamed to the Accounts Service, see above.

##### GitHub repo:

https://github.com/openpermissions/registration-srv

### Repository Operations

#### Repository

##### GitHub repo:

https://github.com/openpermissions/repository-srv

This service provides the management functionality of a Rights Repository.  In addition it also provides approximately the same interface as the query service in order to support direct query access to the service.

#### Identity

##### GitHub repo:

https://github.com/openpermissions/identity-srv

A unique identity called a Hub Key is required for all creations stored within a Right Repository. This service provides a consistent means of generating a Hub Key.

#### Onboarding

##### GitHub repo:

https://github.com/openpermissions/onboarding-srv

Rights data from a Source Repository must be onboarded to a Rights repository.  This service provides the orchestration necessary to achieve this.

#### Transformation

##### GitHub repo:

https://github.com/openpermissions/transformation-srv

Rights data from a Source Repository will mostly not be in [Link TBD CRF] form and will require transforming from the source format to the target format, which is [Link TBD CRF].  This service provides the inbound transformation functionality.

### Discovery Operations

Not in **current release**, future releases will include indexing and similar services.

### Internal libraries

The Open Permissions Platform services share common functionality via libraries.

#### Koi

Koi is a library of tornado extensions. Includes authentication calls used by services.

### External open source platform components

The Open Permissions Platform implementation builds on a number of external components. All external components are open source to ensure that the Open Permissions Platform implementation is open source end to end.

The following components are required:

+ Tornado
+ CouchDB
+ OBlazegraph

## Data principles of the Open Permissions Platform

The Open Permissions Platform stores &lsquo;data about content&rsquo;, and not the content itself. The purpose of the hub is to store and manage that data effectively, to support the intended usage scenarios, and efficiently, to offer acceptable online performance for those scenarios.

For more information about identifiers, please see here including [this](hub-key.md).

### More about permissions and offers

A &lsquo;right&rsquo; is an expression of a term of use for a creation. Many different rights can be attached to a creation: for example, the right to use the creation within a public website, possibly with some conditions around the type of the site (
for example, a &lsquo;non-commercial&rsquo; website) or the amount of traffic it receives (&lsquo;fewer than ten thousand monthly unique visitors&rsquo;); the right to broadcast a creation, possibly with some conditions that distinguish between use in commercial radio or TV programming and use in public service radio or TV programming.

OpenPermissions ODRL is a representation format that enables any arbitrary right to be expressed, and enables rights to be linked to creations and parties.


#### Rights representation formats

Internally the Open Permissions Platform stores and processes all
rights data in OpenPermissions ODRL. 
Rights data that is onboarded to the system is always transformed into
its OpenPermssions ODRL representation from other formats by an inbound transformation service. 


## Security principles

In any geographical region, the Open Permissions Platform is envisaged to be a distributed system of multiple repositories with a single &lsquo;national&rsquo; registry.

The users of Open Permissions Platform services are software applications and other machine clients.

To use the Open Permissions Platform, applications must be known to the system.

In implementation terms, a decorator object is added to an endpoint.

[Link TBD to forthcoming Security Principles doc]

<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
