---
layout: BlogPost
category: blog
title: openHAB 3.0 Release
author: Kai Kreuzer and Yannick Schaus
date: '2020-12-21T11:00:00+01:00'
previewimage: /uploads/wintertrees.jpg
tags:
  - news
excerpt: >-
  The next major release has arrived with openHAB 3! This is exciting news for our community, as it makes openHAB more modern, simpler and yet more powerful.
---
The next major release has arrived with openHAB 3! This is exciting news for our community, as it makes openHAB more modern, simpler and yet more powerful.

<!-- more -->

With openHAB 3 we have reached a new level of both functionality as well user-friendliness. Evolving a product with such a large user base is always a difficult challenge. On the one hand, users  expect new features and functionality to be regularly shipped, while contributors wish to see their own ideas and implementations being accepted and integrated into the project. There is hence the continuous risk of a massive feature creep. On the other hand, new users want a clear path and best practices on how to use the product,  having too many different ways creates  a steep learning curve that can easily confuse them .

The sweet spot for openHAB 3 is in its balance: The underlying framework has been modernized without any negative impact, a lot of complexity has been thrown overboard without dropping features that our users rely on and many things have been streamlined, all of which has enabled our completely new main user interface.

## Architecture Evolution

Version 1 of openHAB consisted of a clean and simple architecture that worked well up to the moment that more "main stream" users joined the community and complemented the existing developer-centric crowd.

Version 2 of openHAB had to compromise between the "old" purely textual openHAB 1 world and the new UI-enabling features that were introduced with Eclipse SmartHome. The way one had to work with bindings and rules very much differed from each other and these two world existed more or less side-by-side, glued together through the 1.x compatibility layer.

With openHAB 3 a huge part of its simplification is due to the removal of the 1.x compatibility layer. All bindings now work exactly the same way and the user decides on how they wish to configure their system, either textually or through a UI. To make sure that nobody is left behind by this move, [many 1.x bindings have been reimplemented](https://github.com/openhab/openhab-addons/issues/6179#migrated) for openHAB 3. For the rest, it is possible to keep an old 2.x instance running while integrating it into a new 3.0 setup - see the [openHAB outposts](#outposts) below.

Furthermore, the two separate rule engine implementations have been merged into one, so that there is now a single concept for automation rules. As a consequence, textual rules written in openHAB's own Rule DSL are also available within the user interface. 

Besides the visible changes, many refactorings have been done to the codebase in order to keep it modern and maintainable. Moving from Java 8 to Java 11 brings the language features on a current level and ensures that openHAB continues to run on JVMs that receive security patches. Additionally, many included libraries have been upgraded, deprecated methods were removed, null annotations introduced, newer OSGi features used and so on. Overall, the codebase is a future-proof and solid foundation to further build on for the years to come.

<p align="center"><video style="max-width: 80%" autoplay loop muted controls="controls" src="/uploads/evolution.mp4"></video></p>

### Outposts

With the new [openHAB Remote Binding](https://www.openhab.org/addons/bindings/remoteopenhab/) it is now very easy to create distributed setups. While in the past many users set up an MQTT broker and integrated multiple openHAB instances using the MQTT binding, openHAB 3 is now capable of discovering other instances on the local network and automatically read its items and things through the REST API.

Such a setup then consists out of a central openHAB instance and several openHAB outposts. This makes sense, if certain devices need physical vicinity, e.g. because they are connected through a serial interface or because their wireless range is not sufficient to reach the central instance, as can be the case for Bluetooth and other short range sensors.

An additional use case (especially considering that some users might still rely on openHAB 1.x bindings that have no equivalent in openHAB 3) is to keep an openHAB 2 instance with the legacy bindings up and running, while migrating the rest of the installation to a new openHAB 3 instance.

## The New User Interface

openHAB 3 introduces a state-of-the-art user interface and deprecates the existing redundant interfaces.  It is designed to cater to every user, whatever their profile, and work on all their screens, from phones to desktops, adapting its look accordingly.

The new "main" UI is a radical change from the previous interfaces in openHAB, but while it introduces entirely new concepts and designs, it still remains faithful to the proven openHAB way. Things and items are still entities defined in different layers - physical and functional - and they are clearly separated and independent of each other in the new user interface.

### Semantic Modelling

Semantic tags were already introduced in openHAB 2, but besides the NLP-focussed HABot chat client, there wasn't yet much use for them. With the new UI, this has now changed. The semantic model lets openHAB understand what your items are representing - whether they are a location such as a room, a physical object or an interaction point. Please refer to our [new beginner tutorial](https://www.openhab.org/docs/tutorial/model.html) for a much more detailed introduction.

Building a model of your home with semantically-tagged items is now recommended and can bring benefits such as cards automatically appearing on the home page, populated with relevant information.

<p align="center"><img src="/uploads/2020-12_semantics.jpg"/></p>

### Blockly for Automation Logic

The new user interface also features a brand new way of designing your automation scripts using [Blockly](https://developers.google.com/blockly), a tool to make your program visually by assembling blocks. Just beware that your kids do not take over your home automation with it!

<p align="center"><img src="/uploads/2020-12_blockly.jpg"/></p>

### New Pages Concept

The UI features new ways of interacting with your system: You can design several new types of pages, including maps and floor plans which many users have asked for in the past. Pages offer extensive features to help navigate your system. 

<p align="center"><img src="/uploads/2020-12_pages.jpg"/></p>

Last but not least, the new user interface is already localized in many languages - and it is very easy to help translating it to further languages. If you are interested, please visit https://translate.openhab.org/!

There is so much more to learn about within the fantastic features of the new UI and if you are interested, be sure to check out the presentation that was done during [our virtual openHAB meetup 2020](https://www.youtube.com/watch?v=pwZ8AOwRDEk&feature=youtu.be).

## New Add-ons

Since the release of openHAB 2.5.0 one year ago, there has been a tremendous activity on add-on development. We have no less than [86 new add-ons](https://github.com/openhab/openhab-distro/releases/tag/3.0.0#newaddons) since then, which highlights the huge coverage of devices that can be integrated with openHAB. There are many awesome things, but I will refrain from picking any example this time.

## Rule Scripting Languages

Besides openHAB's own Rule DSL, it is now also possible to use Javascript, Groovy and Jython for writing automation logic and with Blockly (see above), there is even a graphical way to script automation rules - the Blockly editor simply creates Javascript under the hood. This gives our users the possibility to use their preferred scripting language without sacrificing any of the flexibility of the automation engine, since it is all deeply integrated to work smoothly with each other.

<p align="center"><img src="/uploads/2020-12_scripting.png"/></p>

## Outlook

With 3.0 being released now, the focus of all developers is now clearly on this version. We will continue providing 2.5.x builds for any critical fixes for the next months, but we expect them to be very rare. For 3.x, we aim for minor releases every 6 months as in the past, so expect a 3.1 towards early summer 2021 with monthly milestones on our way there. For critical fixes, we will also consider shipping 3.0.x patch releases for everyone that is on the stable release.

It has been an exciting journey to get openHAB 3 into its current state and it would not have been possible without the extraordinary work from all our maintainers and contributors. I am very happy and thankful that openHAB has truly become a team effort with many maintainers that oversee different part of the project and that maintain, support, plan and drive those parts independently in a professional, reliable and trustworthy way - you rock!

We wish all of you a joyful and relaxed festive season, with enough time to tinker with openHAB 3. Always remember that the safest place in Covid times is close to your keyboard! Stay safe and healthy everyone!
