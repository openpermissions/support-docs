# How to set up and test authenticated access to Hub services

## Contents

+ [About this document](#about-this-document)
+ [Overview](#overview)
+ [Mutual SSL authentication](#mutual-ssl-authentication)
+ [Set up and test SSL authentication](#set-up-and-test-ssl-authentication)
+ [Troubleshooting](#troubleshooting)
+ [Obtaining an SSL certificate for testing](#obtaining-an-ssl-certificate-for-testing)


## About this document

This How-to provides a step by step guide to setting up and testing
SSL authentication against Open Permissions Platform services.

For issues and support, contact
[support@openpermissions.org](mailto:support@openpermissions.org) by email.

### See also

~~See [How to register a new user, organisation, or service]() for a
guide to the Accounts service.~~

__NOTE:__ The Accounts service UI is not yet available to third parties
using the current Hub release. Contact
[support@openpermissions.org](mailto:support@openpermissions.org) by email
for more information about registration.

## Overview

The Open Permissions Platform is implemented as a set of communicating
microservices, around a dozen in the current release. All Hub
microservices communicate through REST APIs, and all APIs, with the
exception of the Query service API, use mutual SSL authentication to
authenticate the endpoint to the caller, and the caller to the
endpoint.

The Query service is deliberately unauthenticated, since it is
intended to be open to all.

For many developers, especially application developers, mutual SSL
authentication may be an unfamiliar security model. Also, certificate
terminology varies widely, with different terms used by different
vendors to describe the same things.

This How-to:

+ Explains why mutual SSL was chosen
+ Provides a step by step guide to setting up and testing SSL authentication against Hub services
+ Includes example code that you can snip, customise, and run to test authentication against Hub staging endpoints

## Mutual SSL authentication

The Open Permissions Platform authentication model is designed to provide a common
approach for all clients of the service, whether these are new
internal microservices, external federated services, other hub instances, or
external third party services or applications.

Mutual SSL authentication is the simplest solution that supports all
of these use cases in the same way.

In mutual SSL authentication, both the service *and* the client use
SSL server certificates to prove their authenticity. Client calls to
the service present the caller's SSL server certificate with the call.

To successfully authenticate:

1. Your SSL server certificate must be accepted by the TLS/SSL protocol layers
2. Your SSL server certificate must be accepted by the Hub endpoint

Point 1 above means that self-signed certificates cannot be used. The
caller must present a certificate that has been signed and issued by a
recognised CA.

Point 2 above means that the caller's certificate must previously have
been registered with the Hub. Uploading a valid certificate is
therefore part of the Hub sign-up process for external organisations/
services.

Mutual TLS/SSL protocols do not enforce any relationship between the
certificate domain and the domain originating an authenticating
request i.e. your API calls can come from any URL, not just the one
identified in your certificate. For test purposes against staging
endpoints, the Hub does not add any further requirements.

__NOTE:__ In the current Hub release, Hub sign-up is a manual process
performed by Hub admins. See [the comments](#see-also)
above.

## Set up and test SSL authentication

Setting up SSL authentication for a client service is straightforward,
but may be an unfamiliar process for developers. The following
sections provide an easy to follow guide.

### 1. Locate or source a suitable SSL certificate

Locate or source an SSL server certificate that you will use
to authenticate to the Hub. This need not be the certificate that your
final service will use. You may want to experiment with a test
certificate while you develop your service or application.

Terminology is not always consistent when describing/discussing
SSL. An SSL "server certificate" is a certificate that is supplied by
a CA to authenticate a URL e.g. one that will be accessed via
SSL. Typically it is supplied with a name of the form
`www_yourdomain_com.crt` or similar. The Apache configuration refers to this
file as the `SSLCertificateFile`.

1. If you manage or have access to the server for your domain you can
use the `SSLCertificateFile` identified in your server configuration
2. If you don't have access to the server and cannot request it, or
don't yet have a running service, you will need to source a suitable
certificate. Several CAs provide free trial certificates, see
[Obtaining an SSL certificate for testing](#obtaining-an-ssl-certificate-for-testing)
below
3. You will also need access to the private key that was used to
   create the CSR (Certificate Signing Request) from which the
   certificate was issued. This is the file Apache refers to as the
   `SSLCertificateKeyFile`. Or, if you are sourcing a new certificate, this
   is the key you will use to generate your CSR

Depending on who issues your certificate, to successfully authenticate
you may need to chain it together with additional certificates
supplied by the CA. We recommend starting with an unchained
certificate file. Follow the
[troubleshooting guidelines](#troubleshooting) to
interpret any errors and chain your certificate if necessary.

### 2. Test the certificate against a Hub endpoint

You don't need to complete the full Hub account sign-up before testing
your SSL certificate against a Hub endpoint. In fact we recommend that
you set up, and if necessary troubleshoot, certificate problems before
completing Hub sign-up.

Use the Onboarding Service staging server authenticated endpoint to
test authentication:

|Service | Endpoint| Authenticated Y/N|
|---|---|---|
|Onboarding|`on-stage.copyrighthub.org`|Y|

__NOTE:__ Do not use production endpoints for service development or
testing. Use the above staging endpoint only.

To test your certificate and key file:

1. Substitute paths to your SSL certificate file and SSL key file in
   the cURL or Python code fragments below
2. Execute the cURL command or the Python script
3. Check the result for an HTTP response code
4. Troubleshoot if required

cURL command:

```
curl -L --key /path/to/my/ssl_key_file.key --cert /path/to/my/ssl_certificate_file.crt \
	https://on-stage.copyrighthub.org
```
Expected result:

```
{"status": 401, "errors": [{"source": "onboarding", "message": "HTTP 401: \
	Unauthorized"}]}
```
Python fragment:

```
# ssl_test.py

import requests

print requests.get('https://on-stage.copyrighthub.org',
	               cert=('/path/to/my/ssl_certificate_file.crt',
				   '/path/to/my/ssl_key_file.key'))
```

Expected result:

```
python ssl_test.py
<Response [401]>
```

The above calls, with the certificate and key paths suitably substituted, should return:
+ HTTP 401 response if your certificate is accepted by TLS/SSL but is not yet
registered with the Hub
+ HTTP 200 OK if your certificate is recognised and accepted by TLS/SSL and the Hub service. Your account is fully set up
+ Any other HTTP response indicates that the certificate has been accepted by TLS/SSL, but the Hub service is rejecting it for some reason

A cURL or Python key, certificate, or CA related error indicates that
your certificate is being rejected by TLS/SSL and not reaching the Hub
service. The two most likely reasons for errors are:

+ Unrecognised CA, for example the following Python error or similar, or cURL equivalent:
```
requests.exceptions.SSLError: [SSL: TLSV1_ALERT_UNKNOWN_CA] tlsv1 alert \
    unknown ca (_ssl.c:590)
```
See [Unrecognised CA](#unrecognised-ca) below

+ Mismatching key file, for example the following cURL error or similar, depending on your platform and cURL version, or Python equivalent:
```
curl: (58) unable to set private key file: '/path/to/my/ssl_key_file.key' type PEM
```
See [Mismatching key file](#mismatching-key-file) below

__NOTE:__ On some Mac OS X versions cURL is reported broken. If you
receive a non-CA or non-key related cURL error, try using the Python
fragment instead.

## Troubleshooting

If your certificate is rejected by the TLS/SSL layer, it will not
reach the Hub service. Instead you will receive an SSL key,
certificate, or CA related error.

The following notes may help troubleshoot SSL problems.

### Unrecognised CA

The most common SSL problem, once you have checked for bad paths,
typos, and similar in your cURL or Python script/command, is that the
CA that has signed and issued your certificate is not recognised. For
example, you may see the following Python error or similar, or cURL
equivalent:
```
requests.exceptions.SSLError: [SSL: TLSV1_ALERT_UNKNOWN_CA] tlsv1 alert \
    unknown ca (_ssl.c:590)
```

1. The Hub uses the
   [Mozilla approved list of CAs](https://mozillacaprogram.secure.force.com/CA/IncludedCACertificateReport). The CA providing your certificate _must_ be in this list. If not, source a new test certificate, see [Obtaining an SSL certificate for testing](#obtaining-an-ssl-certificate-for-testing) below.

2. If your CA is in the list but has not been recognised, you may need to chain CA root and intermediate certificates with your SSL server certificate. See [Certificate chaining](#certificate-chaining) below.

### Mismatching key file

For example, you may see the following cURL error or similar, or
Python equivalent:
```
curl: (58) unable to set private key file: '/path/to/my/ssl_key_file.key' type PEM
```

Double check that the private key you have supplied really is the
matching key for the certificate you are providing.

For example, verify the hashes with this pair of `openssl` commands:
```
openssl x509 -noout -modulus -in /path/to/my/ssl_certificate_file.crt | openssl md5
openssl rsa -noout -modulus -in /path/to/my/ssl_key_file.key | openssl md5
```
The hashes returned by the above two commands should be identical. If
they are not, then you are trying to use the wrong private key.

If you have chained your certificate, certificates chained in the
wrong order can also cause a key file mismatch.

If you are using a chained certificate, verify that the chained
certificate returns the same hash as the above two commands:

```
openssl x509 -noout -modulus -in /path/to/my/chained_ssl_certificate_file.crt | openssl md5
```

See [Certificate chaining](#certificate-chaining), below,
if the first two hashes match but the chained certificate returns a
mismatch.

### Certificate chaining

When a CA issues an SSL server certificate, it may also issue a CA root certificate, and possibly an intermediate certificate.

+ A root certificate identifies the CA that stands at the "root" of
  the "chain of trust" for the CA that issued and signed your SSL
  server certificate
+ An intermediate certificate connects a root certificate to the CA
  that issued and signed your SSL server certificate

If a root or both root and intermediate certificates are required to
authenticate your SSL server certificate, your issuing CA will have
supplied them when it supplied your server certificate.

In this case, you must supply the complete chain of certificates in
order to authenticate successfully.

To chain certificates, for example a root, intermediate, and your own
SSL server certificate, use the Unix (or Mac, or Windows equivalent)
command line to physically concatenate the certificate files.

For example, substitute the paths to the root, intermediate, and SSL
server certificates (in that order) in the command below, and execute on the command line:

```
cat /path/to/my/root_certificate_file.crt /path/to/my/intermediate_certificate_file.crt \
	/path/to/my/ssl_certificate_file.crt >> /path/to/my/chained_ssl_certificate_file.crt
```

The new file `/path/to/my/chained_ssl_certificate_file.crt` will be
written, containing the concatenated text of the three certificate
files.

To verify that the three certificates are now concatenated:

```
% cat /path/to/my/chained_ssl_certificate_file.crt
```

The recommended concatenation order is from most trusted first (the
root certificate) to least trusted last (your SSL server
certificate). If you receive an SSL key error when you test the newly
generated certificate file against an authenticated Hub endpoint,
permute the concatenation order and run the `openssl` hash verification
commands to find which concatenated file returns a match against your
key file. See
[Mismatching key file](#mismatching-key-file) above.

When you test successfully against an authenticated Hub endpoint,
supply this certificate file when you sign up to the Hub.

## Obtaining an SSL certificate for testing

A number of CAs provide free trial SSL server certificates which have
all the features of a full certificate i.e. full signing chain by a
recognised CA. This is useful if you do not have an SSL server
certificate, for example if your service is not yet implemented, or if
you just want to test the Hub staging endpoints.

For example, Comodo appears in the Mozilla list of CAs, and Comodo
certificates are therefore trusted by the Open Permissions Platform (though the
certificates may need chaining). Comodo offer a simple online sign-up
process with email validation and immediate issue of certificates. See
the
[Comodo site](https://www.comodo.com/e-commerce/ssl-certificates/free-ssl-certificate.php) for details.

You will need a URL that you control, and access to the associated
mailboxes to which the CA will send the verification email (you can
easily set up mail forwarding on a new domain to satisfy that
requirement).

To test against Hub staging endpoints using a Comodo certificate,
chain the Comodo root and intermediate certificates with the issued
SSL server certificate (in that order). For example, at the time of
writing Comodo issue a `zip` file that includes the following
certificate files:


|Certificate name|Description|Required in the chain Y/N|
|---|---|---|
|`AddTrustExternalCARoot.crt`|Root certificate for extended validation certificate|N|
|`COMODORSAAddTrustCA.crt`|Intermediate certificate|Y|
|`COMODORSADomainValidationSecureServerCA.crt`|Root certificate|Y|
|`www_yourdomain_com.crt`|SSL server certificate for your domain|Y|

<!-- Copyright Notice -->
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
