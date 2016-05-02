<!--
(C) Copyright Digital Catapult Limited 2016
 -->

# APIs & Doc

## Support Documentation

|||||
|----|---|---|---|
|Overview | [Accounts Service](account-toc.md) | [Query Service](query-toc.md) | [Onboarding Service](onboard-toc.md) |

### Overview

The Open Permissions Platform (OPP) is now available to developers as
an open source project.

The OPP offers public APIs that enable application clients to onboard
metadata **assets** to an OPP platform instance and to query against
those assets for licensing information including **licensors** and
**offers**.

Developers are encouraged to contribute to the project or fork the
code for their own purposes, and organisations and individuals are
encouraged to experiment with deployable services to support their own
activities in the open licensing domain.

For developers wanting to write application clients that integrate
with OPP services, a live instance of the OPP platform powers the
[Open Permissions Platform](http://www.openpermissions.org) and serves as a testbed
for application and service developers and for third-party engagement.

The following topics document the OPP public APIs and provide other
useful information.

#### Security

OPP services, with a few exceptions, accept only authenticated
requests from application clients and collaborating services. The
authentication flow follows OAuth 2.0

[How to authenticate with Open Permissions Platform services](https://github.com/openpermissions/auth-srv/blob/master/documents/markdown/how-to-auth.md)
is a hands-on guide for developers and includes simple code examples
that demonstrate how to request an OAuth token for the most common
client use cases.

### Services

The OPP exposes a small number of RESTful APIs to application clients
and external services. APIs are encapsulated as microservices.

In addition, the platform exposes a web UI to the Accounts Service
that enables user sign-up, account creation, and account management.

The following services expose public APIs:

+ [Accounts Service](account-toc.md) &mdash; Sign-up to an OPP platform
  instance and create and manage accounts

+ [Onboarding Service](onboard-toc.md) &mdash; Onboard metadata **assets** to
  an OPP repository and receive back Hub Keys. Application clients
  must be registered to use this service

+ [Query Service](query-toc.md) &mdash; Query an OPP repository for
  **licensors** and **offers** by asset ID or Hub Key. This is an open
  service for which registration is not required

+ Authentication Service &mdash; Request OAuth access tokens required
  to access authenticated OPP services

### Other useful information

Developers may also find the following documents useful:

+ The [Hub Key Technical Specification V1](
+ The [Hub Key Technical Specification V1](../arch/TECHSPEC_V1.md)
provides a detailed discussion and description of Hub Keys and how
they are used in OPP

+ For developers of application clients that integrate with the
  [Open Permissions Platform](http://www.openpermissions.org) OPP instance,
  [Source ID Types](../types/source-id-types.md)
  lists the source asset types currently supported by that instance
