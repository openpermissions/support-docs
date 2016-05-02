# How to version an API

+ [Acronyms](#acronyms)
+ [Basics](#basics)
+ [When to change versions](#when-to-change-versions)

## Acronyms

| Acronym | Description                   |
| :------ | :----------                   |
| API     | Application Program Interface |
| HTTP    | Hypertext Transfer Protocol   |
| URI     | Uniform Resource Identifier   |

## Basics

APIs are versioned using a **MAJOR** number only. The version of the API appears in it's URI.

For example, this URI structure is used to request version 1 of the 'accounts' API:

```
https://openpermissions.org/v1/accounts
```
and this to request version 2:

```
https://openpermissions.org/v2/accounts
```

The label **latest** should refer to the latest release of the api version.
If there is no version specified then the latest version should also be used.
As an example if the latest version is 2 then

```
https://openpermissions.org/latest/accounts
```

and

```
https://openpermissions.org/accounts
```

should behave in the same way as

```
https://openpermissions.org/v2/accounts
```

Follow the Semantic Versioning 2.0.0 standard for **MAJOR** number format, see [this link](<http://semver.org/spec/v2.0.0.html>)

## When to change versions

The API version number indicates a certain level of backwards-compatibility for the API behaviour.
API clients depend on the expected level of compatibility, and extra care should be taken to maintain their trust.

The following types of changes **DO** require a new API version number:

+ Removed or renamed resource
+ Any **mandatory** change on an existing request
  + e.g. New header required
  + e.g. New data in the body of the request

The following types of changes **DO NOT** require a new API version number:

+ New resource added
+ New HTTP method on an existing resource added
+ Optional additional data is required for a request
+ Request marked as deprecated but still existing (i.e. Requests no longer supported)