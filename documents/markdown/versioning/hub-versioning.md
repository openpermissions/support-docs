# How to version a HUB

+ [Acronyms](#acronyms)
+ [Basics](#basics)
+ [When to change versions](#when-to-change-versions)
+ [The Hub Manifest](#the-hub-manifest)
  + [Manifest example](#manifest-example)

## Acronyms

| Acronym | Description                   |
| :------ | :----------                   |
| API     | Application Program Interface |
| JSON    | JavaScript Object Notation    |
| URI     | Uniform Resource Identifier   |
| URL     | Uniform Resource Locator      |

## Basics

A Hub consists of a set of services that support the APIs defined for the
specific version of the Hub.

The version of the Hub will follow the same rules as that for a service,
details of which can be found [here](service-versioning.md)

## When to change versions

The version of the Hub will change under the following conditions
 
+ Removal of a service
+ Addition of a service
+ Update of a service

The **MAJOR** part of the revision will be updated under any of these conditions

+ The removal of a service
+ An updated service has had a change to its **MAJOR** value

The **MINOR** part of the revision will be updated under any of these conditions

+ The addition of a service
+ An updated service has had a change to its **MINOR** value

The **PATCH** part of the revision will be updated under any of these conditions

+ An updated service has had a change to its **PATCH** value

## The Hub Manifest

The Manifest contains details on the services and documentation required for
the particular version of the Hub.

The file will be formatted as a JSON file. Details on JSON can be found
[here](http://www.json.org)

It will contain a dictionary of services and documentation containing

+ the git clone url
+ version of each service

The version of the service can be a tag or a branch of the repository.

The manifest file should be used in the provisioning process and stored within
a git repository and tagged for each version of the hub.

### Manifest example

```json
{
    "service": {
        "accounts": {
            "url": "https://github.com/openpermissions/accounts-srv.git",
            "version": "1.0.1"
        },
        "authentication": {
            "url": "https://github.com/openpermissions/auth-srv.git",
            "version": "1.0.0"
        },
        "identity": {
            "url": "https://github.com/openpermissions/identity-srv.git",
            "version": "1.0.0"
        },
        "index": {
            "url": "https://github.com/openpermissions/index-srv.git",
            "version": "1.0.0"
        },
        "onboarding": {
            "url": "https://github.com/openpermissions/onboarding-srv.git",
            "version": "1.0.0"
        },
        "query": {
            "url": "https://github.com/openpermissions/query-srv.git",
            "version": "1.0.0"
        },
        "repository": {
            "url": "https://github.com/openpermissions/repository-srv.git",
            "version": "1.0.0"
        },
        "transformation": {
            "url": "https://github.com/openpermissions/transformation-srv.git",
            "version": "1.0.0"
        }
    },
    "documentation": {
        "support": {
            "url": "https://github.com/openpermissions/support-docs.git",
            "version": "1.0.0"
        }
    }
}
```
