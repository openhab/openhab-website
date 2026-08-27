---
layout: BlogPost
category: blog
title: openHAB 3.2 Release
author: Kai Kreuzer and others
date: '2021-12-20T12:00:00-08:00'
previewimage: /uploads/2021-winter-snow.jpg
tags:
  - news
excerpt: >-
  Our winter release of openHAB 3.2 is out! This latest version contains many
  new add-ons, enhanced voice features, automation improvements and more!
---
Our winter release of openHAB 3.2 is out! This latest version contains many new add-ons, enhanced voice features, automation improvements and more!

Another year is coming to its end and so it is time for us to bring you this openHAB release just in time for the festive season!

In the recent days and weeks the IT industry has been dealing with the fallout from vulnerabilities found in the log4j library, aka Log4Shell - prompting around the clock remediation efforts by developers and other IT professionals, especially those who operate Java based systems.

As openHAB is based on Java, we were impacted as well. To ensure we are protecting our users and community, we have addressed the major risks through the [3.0.4 and 3.1.1 patch releases](https://community.openhab.org/t/openhab-and-the-log4j-security-vulnerability/129901/2) that were published shortly after the fixed log4j 2.15 was out. Looking at the statistics of Maven Central that are provided by Sonatype, we have been ahead of many in the general industry, while at least 50% are still consuming vulnerable log4j versions < 2.15:

<p align="center"><img src="/uploads/2021-12-20-log4jstats.png"/></p>

Since log4j 2.15 has been released, many security researchers have focused on testing this new version, and in consequence further (partially less critical) issues were found that led to the latest log4j versions 2.16 and 2.17 being released. We are happy to tell you that openHAB 3.2 already contains the (as of writing) very latest version 2.17, which should give our users a good reason to update their installations. 

This dramatic log4j story has shed light on a larger issue we have in our industry: Open Source maintenance is often only done by engaged individuals in their spare time and their work is rarely recognized by the people that depend on such libraries. In the case of log4j, two passionate developers are taking care of the project in their free time, while nearly the entire Java industry depends on it. These people do a tremendous job and they hopefully get the recognition (and sponsors from the industry) they deserve.

Having said this, I would like to also make sure that our openHAB committers are recognized for their work. While I often do the announcements, I don't contribute to the code base that much anymore - the major work is on the shoulders of many individuals that - most of the time silently - keep coding and contributing to our common project. I therefore like to thank every contributor, especially the ones of the [18 new add-ons](https://github.com/openhab/openhab-distro/releases/tag/3.2.0#newaddons) that are included in the 3.2 release and would now like to give the word directly to some of our maintainers that worked on outstanding new features:

## Rule Engine Enhancements

_Dan Cunningham, openHAB Maintainer_

In the very early days of openHAB, the rules “DSL” was the only standard for writing custom rules.  This Java-like scripting language is based on Xtend and is still used widely today due to its stability and powerful built-in functionality.  Over time however,  the underlying rule infrastructure has matured allowing additional script engines to coexist to provide a true polyglot scripting environment.  openHAB 3.2 ships with multiple script engines including [JRuby](https://www.openhab.org/addons/automation/jrubyscripting/), [Jython](https://www.openhab.org/addons/automation/jythonscripting/), [Groovy](https://www.openhab.org/addons/automation/groovyscripting/), and a ECMAScript 2021 compatible Javascript environment, [JS Scripting](https://www.openhab.org/addons/automation/jsscripting/). 

<p align="center"><img style="max-width: 80%;" src="/uploads/2021-12-20-rule-engines.png"/></p>

### Javascript Script Engine

In openHAB 3.2 we are proud to announce a greatly enhanced version of the GraalVM based JavaScript engine, [JS Scripting](https://www.openhab.org/addons/automation/jsscripting/),  which brings the same ease of use and powerful built-in library of the Rules DSL, but in a modern [ES2021 version](https://en.wikipedia.org/wiki/ECMAScript#Versions) of JavaScript that will be familiar to power users and novices alike.  The enhanced JS Scripting add-on brings together several existing projects into a single, easy to use automation environment.  

Included in this add-on by default is the new [_openhab-js_](https://github.com/openhab/openhab-js) JavaScript library, a fairly high-level ES6 library that provides convenient access to common openHAB functionality including items, things, actions, caches, time functionality, logging and more.  As this library is included in all scripts by default, writing rules is as simple as

```javascript
items.getItem("KitchenLight").sendCommand("ON");
```

No imports, using <code>require()</code> or calling out to Java native types needed!  Even better, the openHAB 3 UI includes support for the [_openhab-js_](https://github.com/openhab/openhab-js) API and offers hinting and autocomplete when editing scripts.

<p align="center"><img style="max-width: 80%;" src="/uploads/2021-rules-script-editor.gif"/></p>

This behavior is configurable, and users can opt to disable automatic imports into scripts for full control of their scripting environment.  Users can continue to use custom built libraries as well as NPM modules through the use of CommonJS Require.  Best of all, [_openhab-js_](https://github.com/openhab/openhab-js) is published as an NPM library, [_openhab_](https://www.npmjs.com/package/openhab) and can be updated or modified by users independently of the built-in version by running <code>npm -i openhab</code> inside the user’s JS automation configuration folder. 

The JS Scripting binding also now includes standard built in global features that users coming from modern JavaScript environments expect to have.  This includes full support of [console logging](https://developer.mozilla.org/en-US/docs/Web/API/Console/log) to the main openHAB log (including debug, trace, info, etc.), timer support with [<code>setTimeout()</code>](https://developer.mozilla.org/en-US/docs/Web/API/setTimeout) and [<code>setInterval()</code>](https://developer.mozilla.org/en-US/docs/Web/API/setInterval) , and importing personal or NPM published packages with <code>require()</code>.  For example, logging in rules is as easy as:

```javascript
console.log("Kitchen Light State", items.getItem("KitchenLight").state);
```

Finally, in previous openHAB versions, installing the JS Scripting binding meant the legacy default Javascript ES5 engine (Nashorn) could not be used.  In practice the two engines had issues coexisting, especially when it comes to UI based rules.  In openHAB 3.2, JS Scripting will use its own directory for files in <code>conf/automation/js</code>, including user provided libraries.  The UI will now show both scripting engines when selecting an action, allowing the user to continue to use the legacy JavaScript engine, or migrate to this new ES2021 based version at their convenience.  

Thank you to Jonathan Gilbert (aka jpg0), who contributed both the JSScripting add-on as well as the _openhab-js_ library. 

## Marketplace and New Visual Automation Possibilities

_Yannick Schaus, openHAB Maintainer_

If you're a regular visitor of the openHAB community forum, you might have noticed it already: there's a new [Add-on Marketplace](https://community.openhab.org/c/marketplace/69) section where our users can come and share their work. We made the choice to keep it self-moderated ([albeit regulated](https://community.openhab.org/t/about-the-add-on-marketplace-category/123408)) by our regular visitors who after reaching a certain trust level, automatically earn curating privileges. Thanks to the associated add-on service, by merely opening a new topic in this category, everyone can effectively publish an add-on that will be featured and installable with a simple click of a button, right from the new add-on store in the openHAB UI. No copy-pasting or putting a .jar file in the addons folder involved!

<p align="center"><img style="max-width: 80%;" src="/uploads/addonstore_32_example.png"/></p>

In the add-on store, you'll find both the trusted add-ons that come with the openHAB distribution (those are clearly identifiable with "openHAB" and a "verified" check mark) alongside community contributions from the marketplace - which allowed to expand what is commonly considered an add-on. You can not only find unofficial bindings and other Java-based extensions, or updates to existing ones (before they hopefully make their way to the distribution), but also new content like UI widgets, as well as rule templates and block libraries that help you with common automation tasks that have been previously solved, and which you can simply learn and profit from instead of reinventing the wheel.

**Rule Templates** have actually existed since openHAB 2 but never became quite useable enough to gain momentum; now they're back with a vengeance to allow creating new rules in seconds, complete with triggers, conditions and actions, including pre-written scripts, just by filling a form to adjust some parameters to your specific configuration. Afterwards you can review what was created and adjust as needed like any other rule. You'll find the add-on store already [well stocked](https://community.openhab.org/c/marketplace/rule-templates/74) with high quality rule templates (mostly) by Rich Koshak, who also notably wrote the design patterns series of articles on the forum. He has also written a [how-to](https://community.openhab.org/t/how-to-write-a-rule-template/128309) on rule templates so more people can join him and contribute.

<p align="center"><img style="max-width: 80%;" src="/uploads/ruletemplate_32_example.png"/></p>

Authoring scripts with Blockly is now open to completely new possibilities: first of all, massive improvements have been made to the built-in openHAB block types offering - kudos to Stefan Höhn for this initiative! From a measly 5 openHAB-related block types in openHAB 3.1, the Blockly toolbox now features no less than 45 of them, organized in 9 categories covering everything from timers, voice and multimedia, to notifications, persistence and more. And while Blockly still uses the default legacy Nashorn ES5 engine under the hood waiting for its replacement showcased above by Dan to mature, its future is bright because it will eventually make the switch once it becomes the default, and leverage all the new features that are coming with it, notably the standard _openhab-js_ library or importing NPM packages.

But that's not all, because you can now also extend Blockly almost limitlessly by writing your own **Block Libraries** that can solve domain-specific or esoteric use cases, and generate reference code that can be reused as easily as dragging a block from the toolbox and configuring it.
And of course there's a [subcategory](https://community.openhab.org/c/marketplace/block-libraries/76) in the Add-on Marketplace to share your block libraries with others, who can install them based on their needs.

<p align="center"><img style="max-width: 80%;" src="/uploads/blockly_32_example.png"/></p>

Follow [this tutorial](https://openhab.org/link/blocklib-tutorial) to learn how to write block libraries. There are a few of them already waiting to be installed from the add-on store, like one to use the new [Twitter binding](/addons/bindings/twitter/)!

<ClientOnly>
  <div style="display:flex;flex-direction:column;align-items:center;">
    <tweet id="1470124826069192704" />
  </div>
</ClientOnly>

In these new visual automation features, there's something for everyone: novices can assemble blocks or create rules from templates, and then study how it was made; but it can appeal to veterans as well from a practical point of view.

## openHAB Skill for Amazon Alexa

_Jeremy Setton, openHAB Maintainer_

A complete rework of the openHAB skill for Amazon Alexa has been released. It introduces a new device-centric metadata syntax in line with the other voice assistant integrations, and simplifies the configuration of basic functionalities while staying backward compatible to ease the transition.

The new metadata syntax acts as a new layer on top of the previous API capability-centric syntax, giving the ability to create new custom pre-configured capabilities that aren’t supported natively by the Alexa Smart Home API yet.

The new skill includes new capabilities for camera, door/window covering, fan, networking and vacuum devices and updates for security panel and thermostat devices.

Additionally, a much improved Main UI integration supporting the new metadata syntax is included in openHAB 3.2. It provides a much better visibility across group endpoints, and tailors the configuration based on item properties and metadata parameters.

<p align="center"><img style="max-width: 80%;" src="/uploads/2021-12-20-alexa-ui.gif"/></p>

The [latest documentation](https://www.openhab.org/docs/ecosystem/alexa/) provides all the necessary information and examples to take advantage of the new syntax.

## Localizing Add-ons

_Christoph Weitkamp, openHAB Maintainer_

Previous versions of openHAB have focused on localizing the openHAB Main UI as well as configuration settings in the core. In this release we have focused on setting up an easy to use translation toolbox for openHAB Add-ons. Our new i18n-tool allows developers to create the default files containing English terms in their familiar Maven environment (just run `mvn i18n:generate-default-translations` in the bundle folder). Once added to GitHub those files will be uploaded automatically to [Crowdin](https://crowdin.com/project/openhab-addons) - a collaboration platform to support multilingual translations. This will allow everyone in our community to translate into their language of choice without requiring any development skills. Completed translations are synced back to our repository periodically. If your language is missing, please help and visit [Crowdin](https://crowdin.com/project/openhab-addons)!

## Summary

These highlights are certainly not all that is new - if you want to learn about all the details, please check out [the official release notes](https://github.com/openhab/openhab-distro/releases/tag/3.2.0).

We wish you a lot of fun automating your home and we are sure that this new release will help you achieving it. If you have any questions or want to share your experiences, do not hesitate to join our [great community](https://community.openhab.org/) and get in touch with us!

Merry Christmas to all of you!
