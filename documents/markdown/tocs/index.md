# APIs & Doc

## Support Documentation

||||||
|----|---|---|---|---|
|Overview | [Accounts Service](account-toc.md) | [Query Service](query-toc.md) | [Onboarding Service](onboard-toc.md) | [Authentication Service](auth-toc.md) |

### Welcome

Welcome to the developer documentation for the Open Permissions
Platform (OPP). The project repositories are now
[public on GitHub](https://github.com/openpermissions), and we invite
you to visit and browse.

OPP is a platform that provides for the storage and management of
licensing information based on an open semantic model, to support
application clients and services that interface to the platform on
behalf of end users.

OPP is designed and implemented as a set of collaborating
microservices that offer a small but useful number of public APIs as
RESTful endpoints.

#### Use, deploy, contribute, extend

For **client developers** writing application clients that integrate
with an OPP instance, [the links below](#opp-apis) provide **How-tos**
and **API references** for the OPP public APIs.

If you are new to OPP, the
[getting started](../guides/getting-started.md) guide introduces basic
platform concepts and provides ready-to-run code examples that will
get you up and running quickly.

For developers who want to **deploy services** to support their own
activities in the open licensing domain, we release ready-to-deploy
"hub-in-a-box" images you can use to spin up your own OPP instance or
individual microservices and build out your own platform, whether for
public, commercial, or internal organisational use.

We welcome **contributors** who want to extend, improve, optimise, or
add to the code base.

### OPP APIs

OPP exposes a small number of RESTful APIs to application clients and
external services. APIs are encapsulated as microservices.

In addition, the platform exposes a web UI to the Accounts Service
that enables client developers to register with the OPP instance and
create services and repositories.

>Note: The first live platform powered by OPP is the **Copyright
>Hub**, a rights exchange for digital content which is operated by the
>[Copyright Hub Foundation](http://www.copyrighthub.org/copyrighthub_org/community/). In
>order to provide developers with concrete examples, code examples
>refer to the `copyrighthub.org` endpoints. If you deploy your own hub
>or are integrating with a different OPP instance, substitute
>appropriate endpoints to run the examples.

#### Security

OPP microservices, with a few exceptions, accept only authenticated
requests from application clients and collaborating services. The
authentication flow follows OAuth 2.0

See
[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md)
for a hands-on guide that includes simple code examples that
demonstrate how to request an OAuth token for the most common client
use cases.

#### Services

The following OPP microservices expose public APIs:

+ [Accounts Service](account-toc.md) &mdash; Sign-up to an OPP
  platform instance and create and manage accounts, services, and
  repositories

+ [Onboarding Service](onboard-toc.md) &mdash; Onboard metadata
**assets** to an OPP repository and receive back Hub Keys. Application
clients must be registered with the OPP instance to use this service

+ [Query Service](query-toc.md) &mdash; Query an OPP repository for
**assets**, **licensors** and **offers** by asset ID or Hub Key. This
is an open service for which registration is not required

+ [Authentication Service](auth-toc.md) &mdash; Request OAuth access
  tokens required to access authenticated OPP services

### Other useful information

Developers may also find the following documents useful:

+ The [Hub Key Technical Specification V1](../arch/TECHSPEC_V1.md)
provides a detailed discussion and description of Hub Keys and how
they are used in OPP

+ For developers of application clients that integrate with the
  [Copyright Hub](http://www.copyrighthub.org/) OPP instance,
  [Source ID Types](../types/source-id-types.md) lists the source
  asset types currently supported by that instance

<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
