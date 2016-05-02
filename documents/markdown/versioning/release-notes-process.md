# Release Notes Process

+ [Acronyms](#acronyms)
+ [Overview](#overview)
+ [Collecting release notes](#collecting-release-notes)
+ [Extracting the release note descriptions](#extracting-the-release-note-descriptions)
  + [Collecting the descriptions](#collecting-the-descriptions)
+ [References](#references)

## Acronyms

| Acronym | Description                   |
| :------ | :----------                   |
| API     | Application Program Interface |
| URI     | Uniform Resource Identifier   |
| JSON    | JavaScript Object Notation    |

## Overview

Release notes are published for each Hub release, detailing the
release changes. Release notes are generated from development workflow
tracking tools.

## Collecting release notes

The release note for each story will be kept on the JIRA issue tracking system
found [here](#http://jira.digicat.io/)

Each completed story MUST have the release notes written up.

Part of the release process will be to collect all the release notes of
completed stories and add them to the head of the distributed release notes
document.

The format of the release notes file will be as follows

```
Date yyyy/mm/dd Version x1.y1.z1
--------------------------------
aaa    Description of aaa
bbb    Description of bbb
ccc    Description of ccc

Date yyyy/mm/dd Version x2.y2.z2
--------------------------------
ddd    Description of ddd
eee    Description of eee
fff    Description of fff
```

## Extracting the release note descriptions

All JIRA tickets pertaining to the project are prefixed with **CHUB**.

Any work performed on a story should be developed on a branch with the same
**CHUB** name as the JIRA ticket or the task within the story.

### Collecting the descriptions

Prior to release all branches merged into the master branch between the
previous and the new release will be queried.

The branch names will be parsed for a JIRA ticket **CHUB** number.

If the **CHUB** number belongs to a story it will be added to the completed story
list if it does not already exist in it.

If the **CHUB** number belongs to a task, a query to find the story that it belongs
to will be performed and the discovered story **CHUB** number will be added to the
completed story list if it does not already exist in it.

Once we have a completed list of completed stories, each story will be queried
for its release note.

The release notes collected will then be added to the head of the Hub release
notes.

## References

1. [JIRA](https://www.atlassian.com/software/jira)
