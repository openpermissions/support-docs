Welcome to the developer documentation for the Open Permissions
Platform (OPP). These notes aim to get you up and running quickly with
the OPP public APIs.

If you want to know more about the OPP platform, and what we built,
and why, read X.

You can find a running instance of OPP at copyrighthub, a copyright
works exchange for the UK powered by OPP. If you want to know more
about the copyright hub, read Y.

Because the copyright hub is built on OPP, the OPP REST APIs are
exposed at the copyright hub endpoint copyrighthub. You can make calls
against these endpoints to onboard and query asset metatdata.

## What we built and how to use it

OPP is a platform that links licensing information in the form of
offers for use, with assets, that's to say copyright works.

An OPP repository stores this information as linked data, and uises an
RDF ontology, the open linked data model, to build and navigate the
linked structures.

Because the OPP model is open, you can customise the model by
extending it to inclde additional concepts. In fact, you can plug in a
completely different model if you want to specialise OPP for some
otyher knowledge domain.

OPP is implemnented as a set of cooperating microservices:

List them and what they do, include that the repo is a triple store:

+
+
+

## Try it for yoursefl

Query a well-known asset

To see how queries work, you don't need anything more than a command
line and cURL, or other language of your choice that allows you to
fire an HTTP request from the command line. See the Query How to for a
code example you can snip. Querying for the following asset (which is
preloaded as an example as part of the platform deployment) should
always return valid data if your code is correct.

You can query for:

+
+
+

See rge how to and API ref for dteails.

Onboard an asset

OPP APIs required authenticated access, with the exception that the
Query service also accepts unauthenticated calls.

To try out the onboarding service, follow the steps in Accounts how to
to register with the OPP hub. It's straihghtforward, just respond to
the automated reply and you're set.

Then log in, create a test service, create a terst repository, and
snip the code in the How to onboard to onboard an asset. Once you've
onboared an asset, you can query for it.

Unbless you link the asset to an offer (which you can do when you
first onboard or by re-onboarding with an offer ID), your query won't
return offer information.

You can try onboarding with a generic Creative Commans offer, using
the offer ID XX.

## Contribute, extend, or deploy

OPP is an open source project.

Youi can find the code in GitHub at XX

### Contributors devs

We welcome contributions from developers who want to extend, improve,
optimise, or add to the code base.

A word about policy.

### Clients dev

If you want tp engage with an existing OPP platform instance, for
example the copyright hub, you can use the APIs to write client
appliactions that allow users to onboard and query assets and offers.

Check ouyt some of the existing copyright hub clisnts to see what's
possible.

### Deploy devs

We publish redy-to-deploy images you can use to spin up your own
hub. You can use OPP to create your own service, for piblic or
internal organisational use.

Current;y we support the following platforms:

X
B
A

## Enjoy

XX











