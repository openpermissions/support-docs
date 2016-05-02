# Open Permissions Platform API Standards v1.1

## Guidelines

This document provides guidelines and examples for Open Permissions Platform APIs, encouraging consistency, maintainability, and best practices across applications.

This document borrows heavily from:
* [White House Web API Standards](https://github.com/WhiteHouse/api-standards/blob/master/README.md)
* [Designing HTTP Interfaces and RESTful Web Services](https://www.youtube.com/watch?v=zEyg0TnieLg)
* [API Facade Pattern](http://apigee.com/about/content/api-fa%C3%A7ade-pattern)
* [Web API Design](http://pages.apigee.com/web-api-design-ebook.html)
* [Fielding's Dissertation on REST](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)

## Pragmatic REST

* Don't do anything weird.
* Put the version number of the API in the URL (see examples below). Don’t accept any requests that do not specify a version number.
* Allow users to request formats like JSON or XML like this:
    * http://example.com/api/v1/magazines.json
    * http://example.com/api/v1/magazines.xml
* JSON is the default format if not specified. For example http://example.com/api/v1/magazines
* Do not specify custom headers.
* **Avoid single-endpoint APIs.** Don't jam multiple operations into the same endpoint with the same HTTP verb.
* **Prioritize simplicity.** It should be easy to guess what an endpoint does by looking at the URL and HTTP verb, without needing to see a query string.
* Prefer variables in the url, query string or request body over http headers.

## Just use JSON

[JSON](https://en.wikipedia.org/wiki/JSON) is an excellent, widely supported transport format, suitable for many web APIs.

Supporting JSON and only JSON is a practical default for APIs, and generally reduces complexity for both the API provider and consumer.

General JSON guidelines:

* Responses should be **a JSON object** (not an array). Using an array to return results limits the ability to include metadata about results, and limits the API's ability to add additional top-level keys in the future.
* **Don't use unpredictable keys**. Parsing a JSON response where keys are unpredictable (e.g. derived from data) is difficult, and adds friction for clients.
* keys should be double quoted
* **Use `_` for keys**.
** After much discussion the policy of underscoring_keys has been decided.  The rational of this being the JSON is a representation of the data, the data is generally represented using underscores, particularly in JSON document stores such as MongoDB, Couch and Riak.
* The data returned in a response should be under a key named `data`.

## Accept serialized JSON in request bodies

Accept serialized JSON on `PUT`/`POST` request bodies, either
instead of or in addition to form-encoded data. This creates symmetry
with JSON-serialized response bodies, e.g.:

```
$ curl -X POST https://service.com/apps \
    -H "Content-Type: application/json" \
    -d '{"name": "demoapp"}'

{
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "demoapp",
  "owner": {
    "email": "username@example.com",
    "id": "01234567-89ab-cdef-0123-456789abcdef"
  },
  ...
}
```

## Use UTF-8

Just [use UTF-8](http://utf8everywhere.org).

Expect accented characters or "smart quotes" in API output, even if they're not expected.

An API should tell clients to expect UTF-8 by including a charset notation in the `Content-Type` header for responses.

An API that returns JSON should use:

```
Content-Type: application/json; charset=utf-8
```

## CORS

For clients to be able to use an API from inside web browsers, the API must [enable CORS](http://enable-cors.org).

## Require TLS

Require TLS to access the API, without exception. It’s not worth trying
to figure out or explain when it is OK to use TLS and when it’s not.
Just require TLS for everything.

Ideally, simply reject any non-TLS requests by not responding to requests for
http or port 80 to avoid any insecure data exchange. In environments where this
is not possible, respond with `403 Forbidden`.

Redirects are discouraged since they allow sloppy/bad client behaviour without
providing any clear gain.  Clients that rely on redirects double up on
server traffic and render TLS useless since sensitive data will already
have been exposed during the first call.

## RESTful URLs

### General guidelines for RESTful URLs
* A URL identifies a resource.
* URLs should include nouns, not verbs.
* Use plural nouns only for consistency (no singular nouns).
* Use HTTP verbs (GET, POST, PUT, DELETE) to operate on the collections and elements.
* You shouldn’t need to go deeper than resource/identifier/resource.
* Put the version number at the base of your URL, for example http://example.com/v1/path/to/resource.
* Formats should be in the form of api/v2/resource/{id}.json
* If needed endpoints should use a hyphen rather than an underscore
  * For example http://example.com/v3/big-endians/my_key/foo-bar

### Good URL examples
* List of magazines:
    * GET http://example.com/api/v1/magazines.json
* Filtering is a query:
    * GET http://example.com/api/v1/magazines.json?year=2011&sort=desc
    * GET http://example.com/api/v1/magazines.json?topic=economy&year=2011
* A single magazine in JSON format:
    * GET http://example.com/api/v1/magazines/1234.json
* All articles in (or belonging to) this magazine:
    * GET http://example.com/api/v1/magazines/1234/articles.json
* All articles in this magazine in XML format:
    * GET http://example.com/api/v1/magazines/1234/articles.xml
* Specify optional fields in a comma separated list:
    * GET http://example.com/api/v1/magazines/1234.json?fields=title,subtitle,date
* Add a new article to a particular magazine:
    * POST http://example.com/api/v1/magazines/1234/articles

### Bad URL examples
* Non-plural noun:
    * http://example.com/magazine
    * http://example.com/magazine/1234
    * http://example.com/publisher/magazine/1234
* Verb in URL:
    * http://example.com/magazine/1234/create
* Filter outside of query string
    * http://example.com/magazines/2011/desc

## HTTP Verbs

HTTP verbs, or methods, should be used in compliance with their definitions under the [HTTP/1.1](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html) standard.
The action taken on the representation will be contextual to the media type being worked on and its current state. Here's an example of how HTTP verbs map to create, read, update, delete operations in a particular context:

| HTTP METHOD | POST            | GET       | PUT         | DELETE |
| ----------- | --------------- | --------- | ----------- | ------ |
| CRUDL OP    | CREATE          | READ      | UPDATE      | DELETE |
| /dogs       | Create new dogs | List dogs | Bulk update | Delete all dogs |
| /dogs/1234  | Error           | Show Bo   | If exists, update Bo; If not, error | Delete Bo |

## Response body

The body of a response should be an object, either an `errors` key or a `data` key.  It should also have a `status` key that is the status code as an integer.

If the request is targeting an individual resource (where the endpoint ends in an id), then the value of the `data` key should be an object.  If the request is targeting a collection (where the endpoint ends in a plural noun), then the value of the `data` key should be an array.  The only exception to this is if the request is a POST and it's body contains a single object then the response should contain a single object.

### Targetting a single resource

```
GET /users/1 HTTP/1.1
```

```
HTTP/1.1 200 OK

{
  "status": 200,
  "data": {
    "id": "1",
    "username": "Mr Flibble",
    "organisations": []
  }
}
```

### Targetting a collection

```
GET /users/ HTTP/1.1
```

```
HTTP/1.1 200 OK

{
  "status": 200,
  "data": [
    {
      "id": "1",
      "username": "Mr Flibble",
      "organisations": []
    },
    {
      "id": "2",
      "username": "Singletoned",
      "organisations": []
    }
  ]
}
```

### POSTing a single resource

```
POST /users/ HTTP/1.1

{
  "username": "newey_newington"
}
```

```
HTTP/1.1 200 OK

{
  "status": 200,
  "data": {
    "id": "3",
    "username": "newey_newington",
    "organisations": []
  }
}

```


## Error handling

### Response body
The body of an error responses should include an array of errors. Each error will include a message and the source. For example:

```
{
  "errors": [
      {
          "source": "template",
          "message": "a relevant text message describing the error"
      }
  ]
}
```

**source** should represent the service that caused the error so if **service1** calls **service2** and **service2** throws the error then **source** should be **service2**

This defines a minimum requirement. A service could also output additional data that could be used in fixing the error.

### Response codes
Use only the following status codes
* 200 - OK
* 400 - Bad Request
* 401 - Request failed because user is not authenticated
* 403 - Request failed because user does not have authorization to access a specific resource
* 404 - Request failed because the resource could not found
* 405 - Request failed because the method is not supported on that endpoint
* 500 - Internal Server Error

When an API Management system is in place the use of the following is also acceptable:
* 429 - Too Many Requests

Response codes should appear as a three digit number with a key of `status` in the response body, as well as in the header.

## Actions

Prefer endpoint layouts that don’t need any special actions for
individual resources. In cases where special actions are needed, place
them under a standard `actions` prefix, to clearly delineate them:

```
/resources/:resource/actions/:action
```

e.g.

```
/runs/{run_id}/actions/stop
```

## Use UTC times formatted in ISO8601

Accept and return times in UTC only. Render times in ISO8601 format,
e.g.:

```
"finished_at": "2012-01-01T12:00:00Z"
```

## Versions

* Never release an API without a version number.
* Versions should be integers, not decimal numbers, prefixed with ‘v’. For example:
    * Good: v1, v2, v3
    * Bad: v-1.1, v1.2, 1.3
* Maintain APIs at least one version back.


## Record limits

* If no limit is specified, return results with a default limit.
* To get records 51 through 75 do this:
    * http://example.com/magazines?limit=25&offset=50
    * offset=50 means, ‘skip the first 50 records’
    * limit=25 means, ‘return a maximum of 25 records’

Information about record limits and total available count should also be included in the response if possible. Example:

    {
        "metadata": {
            "resultset": {
                "count": 227,
                "offset": 25,
                "limit": 25
            }
        },
        "data": []
    }

## JSONP

JSONP is not supported.

## Result filtering and sorting

It's best to keep the base resource URLs as lean as possible.
Complex result filters, sorting requirements and advanced searching (when restricted to a single type of resource) can all be easily implemented as query parameters on top of the base URL. 
Let's look at these in more detail:

### Filtering
Use a unique query parameter for each field that implements filtering. 
For example, when requesting a list of tickets from the /tickets endpoint, you may want to limit these to only those in the open state. 
This could be accomplished with a request like GET /tickets?state=open. Here, state is a query parameter that implements a filter.

### Sorting
Similar to filtering, a generic parameter sort can be used to describe sorting rules. Accommodate complex sorting requirements by letting the sort parameter take in list of comma separated fields, each with a possible unary negative to imply descending sort order. Let's look at some examples:

* GET /tickets?sort=-priority - Retrieves a list of tickets in descending order of priority
* GET /tickets?sort=-priority,created_at - Retrieves a list of tickets in descending order of priority. Within a specific priority, older tickets are ordered first.

## Limiting which fields are returned by the API

The API consumer doesn't always need the full representation of a resource. 
The ability select and choose returned fields goes a long way in letting the API consumer minimize network traffic and speed up their own usage of the API.

Use a fields query parameter that takes a comma separated list of fields to include. For example, the following request would retrieve just enough information to display a sorted listing of open tickets:

* GET /tickets?fields=id,subject,customer_name,updated_at&state=open

This approach doesn't need to be supported by all endpoints, it is useful when large and nested objects are returned by default.

## HATEOS

At present this doesn't seem pragmatic.

## Pretty print by default & ensure gzip is supported

An API that provides white-space compressed output isn't very fun to look at from a browser. Although some sort of query parameter (like ?pretty=true) could be provided to enable pretty printing, an API that pretty prints by default is much more approachable. The cost of the extra data transfer is negligible, especially when you compare to the cost of not implementing gzip.

Consider some use cases: What if an API consumer is debugging and has their code print out data it received from the API - It will be readable by default. Or if the consumer grabbed the URL their code was generating and hit it directly from the browser - it will be readable by default. These are small things. Small things that make an API pleasant to use!

## Future

### HTTP Persistent Connections

Support for this will improve performance and reduce networking overheads.
This is particularly important in a microservice architecture.


### Web Sockets

These are persistent connections that allow bi-directional communications and broadcasting.
This can reduce overheads particularly with the time to setup a connection
By using data packets (JSON data)in our RESTful API that encapsulates all data required for a request we allow easier sharing of code between the different protocols.

### Web RTC

Probably a little immature at this stage, but potentially beneficial in similar ways to Web Sockets.

# Ammendments to v1.0

  1. Every response should be a response object, to allow metadata about the response
  2. The key that holds the data should be named `data` and be at the top level of the response object.
  3. Each response should have a `status` key, which matches the status code of the request and is a 3 digit integer from our allowable set of status codes.
  4. The `source` (ie service) of each error should be included in each error object in the array of errors.  It should not be at the response level.
  5. We should be liberal on what we accept with regards to headers.  If a request has no CONTENT_TYPE header, we should assume that it is JSON and proceed normally.  If a request has no ACCEPTS header, we should assume they want JSON back.  We should be strict with ourselves in what we send back.
  6. Status code 405 (method not allowed) should be returned when an endpoint exists, but doesn't accept that method.
  7. Requests that target an endpoint that ends in a id should recieve a response with an object as the value of the `data` key.  POST requests that contain one object in the body should recieve a response with an object as the value of the `data` key. All other responses should have a list as the value of the `data` key.
  8. DELETE requests should receive an object or list of objects with at least the `id` key in them.  No more is neccessary.
