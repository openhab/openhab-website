---
layout: BlogPost
category: blog
title: openHAB 3.3 Release
author: Dan Cunningham
date: '2022-06-27T00:30:48-07:00'
previewimage: /uploads/summer.jpg
tags:
  - news
excerpt: >-
  We are pleased to announce our summer release of openHAB 3.3 is out! This
  latest version contains many new add-ons, enhanced features, automation
  improvements and more!
---
Summer is here, and with it comes the next version of our smart home platform, openHAB 3.3. The last six months have shown an impressive amount of activity across our different components including openHAB Core, Add-ons, UI, Android, iOS and Javascript library to name just a few. 

You can find the full list of new add-ons, enhancements and fixes in our [**official release notes**](https://github.com/openhab/openhab-distro/releases/tag/3.3.0).

With that being said, we wanted to share some statistics that highlight the awesome progress our developers have made with this release.

# Activity

Since our [winter release](https://www.openhab.org/blog/2021-12-19-openhab-3-2-release.html) we have introduced 25 new add-ons, including multiple text to speech (TTS) engines, multiple weather integrations as well as additional integrations into cars, lighting and environmental systems, music systems and many more. Our [Github add-on repository](https://github.com/openhab/openhab-addons) saw 722 pull requests as well as 234 enhancements and 195 bug fixes to existing add-ons. Cumulatively these improvements added an additional 122,308 new lines of code to our project. That’s a lot of activity! 

The [openHAB core](https://github.com/openhab/openhab-core), which provides the foundational services for the openHAB platform, was also very active with 263 pull requests, 65 enhancements, 72 bug fixes and 10,767 new lines of code added. 

Finally our [user interfaces](https://github.com/openhab/openhab-webui) had a flurry of activity with 9,687 new lines of code and 88 pull requests, including 41 enhancements and 15 bug fixes to the new Main UI.

Our [community](https://community.openhab.org/) has been growing as well over the last 6 months with an additional 1400 new users signed up, with over 800 of these users posting for the first time. Additionally our forums saw over 135,000 user visits and over 26,000 user posts. Impressive numbers indeed.

# Highlights

While there are too many new features and enhancements to list here, we wanted to highlight a couple efforts which we think are particularly impactful.

## iOS Client

Our iOS team has been hard at work to support the openHAB 3.3 UI in our iPhone and iPad client. The current release supports using the Main UI in a full screen view along with support when using remotely through [**myopenHAB.org**](https://myopenhab.org/). Keep on the lookout for our next release which will include enhancements for making the Main UI selectable as the main entry point into the application as well as enhancements to make the Main UI view more resilient to network conditions.

<p align="center"><img style="max-width: 60%;" src="/uploads/2022-06_ios_mainui.gif"/></p>

## openHAB Javascript Library

Our [Javascript automation runtime library](https://github.com/openhab/openhab-js) has reached version 2.0 and contains many enhancements and fixes over the first version which shipped in our winter 3.2 release. One such enhancement is an overhauled Typescript based definition system which greatly improves autocompletion in an IDE like Visual Studio Code. In addition, our Main UI has been updated with additional autocomplete helpers for new features in the Javascript library making it easier than ever to write rules.

<p align="center"><img style="max-width: 70%;" src="/uploads/2022-06_webui_rules_autocomplete.gif"/></p>

## Thank You!

From all of us at [openHAB](https://www.openhab.org/) we would like to thank our community of users and developers for their continued support of our project. As always our [community forums](https://community.openhab.org/) are there for questions, comments and discussions. We hope you will enjoy our newest release and happy automating!
