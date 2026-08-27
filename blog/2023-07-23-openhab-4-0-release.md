---
layout: BlogPost
category: blog
title: openHAB 4.0 Release
author: Florian Hotze and others
date: '2023-07-23T18:00:00+02:00'
previewimage: /uploads/2023-07-23-openhab-4-0-release/header.jpg
tags:
  - news
excerpt: >-
  A new major release has arrived! openHAB 4 brings some exciting new features and several improvements for our users as well as our developers!
---
A new major release has arrived! openHAB 4 brings some exciting new features and several improvements for our users as well as our developers!

With openHAB 4, we have finally reached feature parity between UI-based and file-based configurations, with UI support for both transformation and persistence configuration.
Additionally, we have added support for using any of the supported script languages for transformations and profiles, and we've leveled up Units of Measurement (UoM) support.
But that's not all!
As quite usual for new openHAB major releases, we also upgraded to Java 17 to stay in sync with the evolving Java ecosystem.
Java 17 brings a wealth of benefits to our user and especially our developers, including security enhancements, performance improvements and reduced memory usage as well as new language features and APIs.

As this is a new major release, we have a number of breaking changes that are required for the new features and improvements.
So, please have a look at our [**official release notes**](https://github.com/openhab/openhab-distro/releases/tag/4.0.0) to learn about all breaking changes, new add-ons, enhancements and fixes.

With that being said, we again want to share some statistics that show the progress in numbers.

# Activity

As you'd expect from a new major release, we have had a really high activity across all our GitHub repositories since our [winter release](/blog/2022-12-19-openhab-3-4-release.html).
We therefore want to share a few statistics about our three main repositories: Core, add-ons and UI.

[openHAB core](https://github.com/openhab/openhab-core), which is like the heart of openHAB, has received 260 pull requests, 68 bug fixes and 94 enhancements with 13,171 lines of code added.
The number of pull requests has doubled up compared to our [winter release](/blog/2022-12-19-openhab-3-4-release.html).

17 new add-ons were introduced, and with 748 pull requests, 153 bug fixes and 214 enhancements resulted in 117,453 lines of add-on code added to [openHAB add-ons](https://github.com/openhab/openhab-addons).

Our [openHAB web UIs](https://github.com/openhab/openhab-webui) were also very actively developed, with 174 pull requests, 54 bug fixes and 83 enhancements and 10,440 lines of code added.
That's nearly three times the number of pull requests compared to our [winter release](/blog/2022-12-19-openhab-3-4-release.html).

It is worth to mention, that [our other repositories](https://github.com/openhab) have also received numerous contributions (e.g. documentation), but listing them all would probably be too much here.
Thank you to all our contributors for driving openHAB forward!

Finally, it is time to shout out to our top code contributors per repository (having done the most commits) for this new release:

- Jan ([@J-N-K](https://github.com/J-N-K)) for openHAB core
- Jacob ([@jlaur](https://github.com/jlaur)) for openHAB add-ons
- Laurent ([@lolodomo](https://github.com/lolodomo)) for openHAB add-ons
- Florian ([@florian-h05](https://github.com/florian-h05)) for the openHAB web UIs

All of them are also maintainers, which means besides of contributing code, they review pull requests and participate in discussions on GitHub issues.
At present, there are 37 maintainers across all our repositories.
I extend a huge thank you to all my colleagues for their exceptional contributions in advancing openHAB!

# Highlights

As this is a major release, there are some major (breaking) changes, but there is no single big new thing (like the introduction of Main UI in openHAB 3) to learn about.
Instead, we have quite a large number of new features and enhancements, and we hope everyone finds something that matters to them.

Therefore, please have a look at the [**release notes**](https://github.com/openhab/openhab-distro/releases/tag/4.0.0) and check out the following highlights.

## Core Runtime Enhancements

_Jan N. Klug, openHAB Maintainer_

A lot of changes are under-the-hood.
Some of them can't be seen directly, but they all improve your openHAB experience.
The core support for some UI features (like managing transformations and persistence from UI) resulted in large refactoring of the underlying core components, which not only future-proofed our code, but also resulted in performance improvements and bug fixes.
This is also true for the watch-service (the component that tracks changes to files) and the event handling in general.

There are three things I would like to point out: Units of Measurement, scripting and Thing upgrades.

### Units of Measurement (UoM)

We finally made handling of units more consistent in openHAB.
In some cases the "old" code had surprising effects (e.g. changing the display unit in a state description corrupted persisted data).

I strongly recommend to re-read [the documentation](/docs/concepts/units-of-measurement.html) and the [upgrade instructions](https://github.com/openhab/openhab-distro/releases/tag/4.0.0#breaking-changes-that-require-manual-interaction-after-the-upgrade).

To make a long story short: We now introduced `unit` metadata that fixes the unit for a given Item.
This unit is assumed if a value with no unit is sent to the Item and the same unit is used when data is persisted.
The unit set in a state description is only used for displaying, it does no longer affect the handling of the Item's state internally.

### Scripting

#### Transformation and Profile

openHAB 3.4 introduced the `SCRIPT` transformation, but a profile was still missing.
We used the introduction of the profile to also improve handling of the transformation.
With openHAB 4 you can use any scripting language you like to create transformation scripts (even in the UI, see below) and use all of these as a profile when linking channels and Items.

Please have a look at [the documentation](/docs/configuration/transformations.html#script-transformation) for more information.

#### Startup Behavior

With the increasing popularity of scripting languages (like JavaScript and Ruby) besides openHAB's classic DSL some issues regarding the startup behavior became more obvious.
For openHAB 4 we re-worked the startup process, and it finally is a much more deterministic startup behavior.
The runtime now ensures that the necessary add-ons are initialized before it tries to run rules.

#### Rule Triggers

In most scripting languages information about the reason why the rule has been triggered is available, but in the past this was limited to Item events (i.e. no information was given for time-based triggers or start-level-triggers).
With openHAB 4 you have much more control: You can extract the information about the rule trigger for all trigger types.

### Thing Upgrades

If you used managed (i.e. UI-configured) Things in the past, you will have noticed that when a breaking change in a binding occurred, you had to delete the thing and re-add it, requiring a full re-configuration (including channel-links).

With openHAB 4 we introduced "Thing upgrades".
Add-on developers can now provide instructions to automatically upgrade things when openHAB upgrades.
This is already the case for a lot (but unfortunately not all) breaking changes in this release.

## UI Enhancements

_Florian Hotze, openHAB Maintainer_

Especially as a new member of the UI maintainers team (i.e. duo — it’s just Yannick Schaus and me), I’m really excited to introduce you to the following enhancements, which are only a part of all the changes that have been contributed to our web UIs.

### Blockly

_Stefan Höhn, openHAB Blockly Maintainer_

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-07-23-openhab-4-0-release/blockly4.0.png"/></p>

A lot has happened since openHAB 3, particularly with the promotion of all blocks to the new and latest JavaScript engine that comes with openHAB 4.
Not only does that generate even cleaner code, but it also allows the implementation of many more features that would have been hard to provide. 
Therefore, all blocks have been rewritten for openHAB 4 to support the new JavaScript engine.

**How the 🦏 found the holy Graal - The new code generation**

Even though one may not notice it directly, the blocks are eventually used to automatically create code that can run on the openHAB server.
Please watch the YouTube video [Blockly as an ECMA-Script code generator](https://youtu.be/EdllUlJ7p6k?t=1739) for a live demo.
The code that is generated can be viewed when clicking the button in the lower right corner of the Blockly editor.

In general, the code that Blockly generates is JavaScript (aka ECMAScript) which exists in several flavours or versions.
The ECMAScript version that is used by Blockly in **openHAB 3** is **ECMAScript 5.1,** and it is run by a component named **NashornJS** 🦏. [Nashorn JS](https://www.oracle.com/technical-resources/articles/java/jf14-nashorn.html) itself was part of Java until version 14 when it was dropped.
The generated rule code is run within the Java runtime (also known as JVM) on the openHAB server and as openHAB 4 has moved to Java 17, the old ECMAScript 5.1 is not directly available anymore within the JVM via Nashorn.
A replacement for the Nashorn JS is **GraalJS** ("the holy grail"), which is currently running **ECMAScript 2022** and therefore supports all modern JavaScript features, like arrow functions and private class fields and methods.
[**GraalJS**](https://github.com/oracle/graaljs) is already available in openHAB 3 when the [JavaScript Scripting add-on](/addons/automation/jsscripting/) is installed.
The [JavaScript Scripting add-on](/addons/automation/jsscripting/) also includes the [openHAB JavaScript library (openhab-js)](https://github.com/openhab/openhab-js), which in fact empowers most of the new Blockly features and allows the much cleaner code by providing a simple, pure JS API to openHAB.

**New Features in Blockly**

* Full Support of **U**nits **o**f **M**easurement with [5 brand-new blocks](/docs/configuration/blockly/rules-blockly-uom.html)
* The [Math section](/docs/configuration/blockly/rules-blockly-standard-ext.html#math) has been extended by a new bitshift block and extended rounding block
* Metadata blocks allow direct access to [Item metadata](/docs/configuration/blockly/rules-blockly-items-things.html#item-metadata)
* A historicState option has been added to the [persistence blocks](/docs/configuration/blockly/rules-blockly-persistence.html#get-statistical-value-of-an-item)
* Persistence blocks can now be used with any [persistence service](/docs/configuration/blockly/rules-blockly-persistence.html)
* Added pattern to [text of date block](/docs/configuration/blockly/rules-blockly-date-handling.html#get-string-representation-of-date-text-of)
* Support for [private and global cache](/docs/configuration/blockly/rules-blockly-value-storage.html#caching) when using the value storage blocks
* A new [Blockly dictionary loop](/docs/configuration/blockly/rules-blockly-standard-ext.html#loop-over-a-dictionary) block with value and key from dictionary
* Added stricter type checking for blocks to avoid mistakes
* Added numeric state, quantity state to getItemAttribute

Editor:
* [Search](/docs/configuration/blockly/rules-blockly-before-using.html#searching-the-workspace) within the Blockly workspace via Cmd/Ctrl-F
* Shadow Blocks are now automatically converted to real blocks, which is good when you want to reuse them by duplicating the block 
* [Cross-Rule Copy & Paste](https://next.openhab.org/docs/configuration/blockly/rules-blockly-before-using.html#cross-rule-copy-paste)

All new blocks have received comprehensive documentation at the [Blockly Reference](/docs/configuration/blockly/).

### Scene Editor

Given several discussions in the community, support for scenes was a long awaited feature — openHAB 4 has it.

Basically, scenes are only a set of Items and states that the Items are commanded to when the scene is enabled.
In openHAB, a simple rule would be enough to achieve this functionality, but it would either require some coding or several UI interactions.

The scene editor allows you to define Items and their respective target states very easily.
A sync state button allows storing the current Item state as the target state, and another button allows testing the currently defined target state.

Scenes can be triggered from Main UI widgets and, as they are basically just rules without triggers, from other rules. 
One may wonder how to trigger scenes from Basic UI: In this case, you can create an Item and use the code tab of the scene to define it as a trigger.

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-07-23-openhab-4-0-release/scene-editor.png"/></p>

If you are interested, please check out [the documentation](/docs/tutorial/rules_scenes.html).

### Transformation Editor

Previously, it was only possible to define transformations through files in the respective folder, but this release brings UI-based configuration of transformations.

The transformation editor basically is just a code editor with syntax highlighting for the selected transformation type, and pre-filled code snippets for some script-based transformations, but it is an important part of reaching feature parity between file-based and UI-based configuration.

The upcoming openHAB 4.1 release will probably improve the UI, so you can simply select which transformation you want to apply on an Item state, but until then the transformation editor provides guidance what to fill into the state description field.

### Persistence Configuration

Seems like openHAB 4 is full of new UI pages — It finally supports configuring persistence from the UI.

As most UI configuration pages, the persistence configuration page is divided into two tabs: A design and a code tab.

The design tab allows to graphically configure strategies and filters for selected Items, create new cron strategies (common ones are automatically created for you) and manage filters.
openHAB 4 also has a few new filters you should check out!

The code tab represents the persistence configuration in YAML code and is perfect for sharing, e.g. when asking for help on the forum, but everything can be configured without touching a single line of code.

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-07-23-openhab-4-0-release/persistence-editor.png"/></p>

To try it yourself, open a persistence add-on’s settings from the add-on store and click on the blue “Persistence configuration” header.

### Developer Sidebar Search

In openHAB 3, the developer sidebar search was only able to find Items by name or label, Things by UID or label, rules by UID or name and pages by UID.

With openHAB 4, we gave it a big upgrade:
It is now possible to search inside nearly every UI entity. 
No matter what, you find what you search for.

Imagine you want to know which of your rules and pages use a specific Item.
Just type the Item name in the developer sidebar search, and you’ll find all occurrences of the search query in pages, scenes, scripts and rules. 
Even Blockly and the code of script actions are now searchable.

<p align="center"><img style="max-width: 55%;" src="/uploads/2023-07-23-openhab-4-0-release/developer-sidebar.png"/></p>

For an exact list of entities the search checks your query against, please have a look at [the documentation](/docs/tutorial/tips-and-tricks.html#search).

### New Input Field for Sitemap UIs

_Laurent Garnier, openHAB Maintainer_

No new user interface elements have been added for sitemap UIs since openHAB version 1.
This finally changes with openHAB 4 with the introduction of a new UI element long-awaited by users: The `input` field.

```java
Input item=<itemname> [label="<labelname>"] [icon="<iconname>"] [inputHint="<inputHint>"]
```

This element allows entering of text, numbers and dates/times and updating the underlying items.
Text, number or number with unit values and dates/times can be updated in the respective Item types.

The parameter `inputHint` will give a hint to the user interface to use a specific widget adapted to a specific use.
For example, it can be a time picker or a date picker. Valid values for the parameter are `text`, `number`, `date`, `time` and `datetime`.
Support of these widget types vary by user interface and/or browser.

This new input field is already supported in Basic UI and in the Android app.

There are many use cases for this feature.
For example, it can be used for entering manual meter readings - or perhaps drawing attention from your family:

`items/tv.items`:

```java
Switch LGTV_Power "Power" { channel="lgwebos:WebOSTV:tv:power" }
Player LGTV_Control "Control" { channel="lgwebos:WebOSTV:tv:mediaPlayer" }
String LGTV_Toast "Toast" { channel="lgwebos:WebOSTV:tv:toast" }
```

`sitemaps/tv.sitemap`:

```perl
sitemap tv label="TV" {
  Switch item=LGTV_Power
  Default item=LGTV_Control visibility=[LGTV_Power==ON]
  Input item=LGTV_Toast icon="screen" inputHint="text" visibility=[LGTV_Power==ON]
}
```

Android app:

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-07-23-openhab-4-0-release/basicui-input-androidapp.png"/></p>

LG TV:

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-07-23-openhab-4-0-release/basicui-input-lgtv.jpg"/></p>

Many thanks to Mark Herwege ([@mherwege](https://github.com/mherwege)) who fully implemented this new feature (sitemap syntax update in core framework, implementation in Basic UI and in the Android app).

### Open openHAB to Thousands of Free New Icons

_Laurent Garnier, openHAB Maintainer_

#### New icon sources available

In addition to the icons already provided via the openHAB server (classic icon set + custom user icons), you have now easy access for your Items and sitemap elements to the [Material icons](https://fonts.google.com/icons?icon.set=Material+Icons), [Framework7 icons](https://framework7.io/icons/) and [over 150,000 icons provided by Iconify](https://icon-sets.iconify.design/).

Main UI supports all these icon sources while Basic UI currently supports all of them except Framework7.
Note that Iconify icons require internet connectivity on the client to access the external API.
The web browser will cache the retrieved icons to limit the requests and speed up the rendering.
Basic UI provides a setting to enable this option, which is disabled by default.

Dynamic icons based on the Item state remain a feature only available when using the openHAB icon sets.

For more details including the new category/icon syntax, please read [the documentation](/docs/configuration/items.html#icons).

#### Managing your icon color

You can now control the icon color associated with any user interface element of a sitemap using the `iconcolor` parameter.
The syntax and capabilities behind this parameter are the same as for the `labelcolor` and `valuecolor` parameters, which means you can define multiple conditions leading to different colors.

This is not possible with icons from the classic icon set because these icons have a hard-coded color palette, but it is possible with icons from other icon sources and with user-added SVG icons using `currentColor` as the fill color.
Basic UI supports this color feature for openHAB icons only if an option is enabled.
Color support for other icon sources is supported by default.

For more details, please read [the documentation](/docs/ui/sitemaps.html#label-value-and-icon-colors).

#### Icons provided by bindings

A binding can now make specific icons related to channels available to the user, especially when no appropriate category/icon is available in the classic icon set.
A few bindings have already integrated this feature, for example the [OpenUV binding](/addons/bindings/openuv/).

## Add-on Enhancements

_Jacob Laursen, openHAB Maintainer_

17 new add-ons are included, adding support for new devices and services.

The [PLEX binding](/addons/bindings/plex/), which has been missing since version 2.x, is back!
The [Android TV binding](/addons/bindings/androidtv/) enables interaction with Google TV and Nvidia ShieldTV.
The [Ecovacs binding](/addons/bindings/ecovacs/) integrates a variety of vacuum cleaning/mopping robots.
The [Energi Data Service binding](/addons/bindings/energidataservice/) provides electricity prices primarily for Scandinavia, and with the [VAT transformation](/addons/transformations/vat/), VAT is included according to your configured country.
The [ChatGPT binding](/addons/bindings/chatgpt/) allows AI interactions where only your imagination sets limits to the usage. How about announcing the weather forecast in a personalized way on your preferred speaker?

Some existing bindings also received massive overhauls:

- The [Philips Hue binding](/addons/bindings/hue/) has been rewritten to support API v2, offering real-time updates from lights, switches and sensors.
- Similarly, the [Hunter Douglas PowerView binding](/addons/bindings/hdpowerview/) now supports the new PowerView Gen 3 system with blazingly fast updates.
- The [deCONZ binding](/addons/bindings/deconz/) has been improved with new features and many bugfixes and stability improvements.
- The [Freebox binding](/addons/bindings/freebox/) is replaced by a [new binding](/addons/bindings/freeboxos/) rewritten from scratch.
- The [KNX binding](/addons/bindings/knx/) introduces UoM support, respecting the DPT of a GA (group address), and has received a larger code refactoring with improved performance and stability.

### JavaScript Scripting

_Florian Hotze, openHAB Maintainer_

openHAB 4 also includes enhancements to the JavaScript Scripting automation add-on, and the [openHAB JavaScript library (openhab-js)](https://github.com/openhab/openhab-js).

We have worked both on reducing the memory usage (by approx. 30%) and also improving the performance.
By caching the injection of the helper library, we were able to reduce the initial evaluation time of a script to approx. a sixth compared to not-caching the helper library injection.

But as already said, we not only worked on the add-on - the library also received numerous enhancements, including a rewrite of the Item metadata and channel-link APIs and the new `Quantity` API.
The [`Quantity` API](/addons/automation/jsscripting/#quantity) allows handling of UoM, e.g. unit conversion, inside your JS scripts by utilizing the UoM capabilities provided by openHAB Core.

To get informed about all breaking changes, enhancements, and fixes, have a look at [the openhab-js changelog](https://github.com/openhab/openhab-js/blob/v4.5.0/CHANGELOG.md).

### JRuby Scripting

_Jimmy Tanagra, openHAB Maintainer_

The [JRuby Scripting add-on](/addons/automation/jrubyscripting/) is now based on JRuby 9.4 which supports Ruby 3.1 syntax.
Its helper library is installed by default and can be used in UI-based rules, file-based rules, and in [transformations](https://openhab.github.io/openhab-jruby/main/index.html#transformations).

Highlights of `JRuby Helper Library's` features:

* Make rules more succinct and [easier to read, write, and maintain](https://openhab.github.io/openhab-jruby/main/file.examples.html) by providing an extensive support for common use cases as well as supporting advanced requirements.
* Include a [comprehensive documentation](https://openhab.github.io/openhab-jruby/) based on YARD which includes detailed examples.
* Compare [date, time, and duration](https://openhab.github.io/openhab-jruby/main/index.html#time) seamlessly, e.g. `Alarm_Time.state > Time.now + 1.hour`.
* Compare items' state with [Quantity and Unit of Measurement](https://openhab.github.io/openhab-jruby/main/OpenHAB/Core/Types/QuantityType.html) seamlessly, e.g. `Outdoor_Temperature.state > 74 | "°F"`
* [Manage multiple reentrant timers](https://openhab.github.io/openhab-jruby/main/OpenHAB/DSL.html#after-class_method), without having to write long and complex code to keep track of timers, e.g. `after(10.minutes, id: Porch_Light) { Porch_Light.off }`.
* Provide a simplified way of calling [thing actions](https://openhab.github.io/openhab-jruby/main/OpenHAB/Core/Things/Thing.html#actions-instance_method), e.g. `things["mqtt:broker:mosquitto"].publish_mqtt(...)`.
* Allow dynamic creation of things and items through [Things builder](https://openhab.github.io/openhab-jruby/main/OpenHAB/DSL/Things/Builder.html) and [Items builder](https://openhab.github.io/openhab-jruby/main/OpenHAB/DSL/Items/Builder.html).
* And much more...

# Enjoy and Get in Touch!

We hope that you like the new release as much as we do - as always our [community forums](https://community.openhab.org/) are there for questions, comments and discussions. Do not hesitate to get in touch, join our community, receive help and share your experiences and use cases.
