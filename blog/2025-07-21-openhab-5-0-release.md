---
layout: BlogPost
category: blog
title: openHAB 5.0 Release
author: Florian Hotze and others
date: "2025-07-21T20:00:00+01:00"
previewimage: /uploads/2025-07-21-openhab-5-0-release/header.webp
tags:
  - news
excerpt: >-
  A new major release of openHAB is here! openHAB 5.0 comes with a lot of exciting new features and improvements, including Matter support, a new Python Scripting add-on and a ton of other enhancements.
---

A new major release of openHAB is here!
openHAB 5.0 comes with a lot of exciting new features and improvements, including Matter support, a new Python Scripting add-on and a ton of other enhancements.

But that's not all!
As usual for major releases, we have also made some major changes under the hood:
We have officially **dropped 32-bit support**, **moved to Java 21** and **upgraded our dependencies** to ensure long-term maintainability and take advantage of the latest features (e.g. virtual threads) and improvements in the Java ecosystem.
We understand that dropping 32-bit support is a significant change, but it was necessary for upgrading several dependencies that no longer support 32-bit architectures — outdated dependencies often have security vulnerabilities.
That being said, it also reduces maintenance overhead by allowing us to focus on 64-bit systems, which are nowadays standard for most applications.

As this is a major release, we have a number of breaking changes that are required for the new features and improvements.
So, please have a look at our [**official release notes**](https://github.com/openhab/openhab-distro/releases/tag/5.0.0) to learn about all breaking changes, new add-ons, enhancements and fixes.

With that being said, we again want to share some statistics that show the progress in numbers and highlight some of the new features that you should not miss.

# Activity

Behind every new feature in openHAB 5.0 is the work of a vibrant, global community.
Over the past period, activity across our GitHub repositories has been nonstop — a reflection of openHAB’s momentum and shared purpose.
In total, 140 contributors contributed a whopping 2470 commits to our [GitHub repositories](https://github.com/openhab)!

This release includes contributions across all parts of the system:

- **[Core](https://github.com/openhab/openhab-core)**: 251 pull requests, with 50 bug fixes and 94 enhancements, resulting in 20,380 lines of added code.
- **[Add-ons](https://github.com/openhab/openhab-addons)**: 20 new add-ons, 201 fixes and 232 enhancements, across 694 pull requests — adding 886,656 lines of code.
- **[UIs](https://github.com/openhab/openhab-webui)**: 226 pull requests, 79 bug fixes, and 105 enhancements, totalling 7,711 new lines of code.

Many [other repositories](https://github.com/openhab) — including documentation, openHABian, and build tooling — also receive steady contributions, too numerous to list here.

Huge thanks to everyone who continues to push openHAB forward!

Again, it is time to shout out to our top code contributors per repository (having done the most commits) for this new release:

<!-- https://github.com/florian-h05/github-stats?tab=readme-ov-file#contribution_stats -->

- Holger ([@holgerfriedrich](https://github.com/holgerfriedrich)) for openHAB Core
- Jim ([@jimtng](https://github.com/jimtng)) for openHAB Core
- Jacob ([@jlaur](https://github.com/jlaur)) for openHAB add-ons
- Andrew ([@andrewfg](https://github.com/andrewfg)) for openHAB add-ons
- Florian ([@florian-h05](https://github.com/florian-h05)) for the openHAB Main UI
- Jim ([@jimtng](https://github.com/jimtng)) for the openHAB Main UI

Many of these contributors also serve as maintainers — reviewing pull requests, discussing architectural changes, and supporting newer contributors.
At the time of this release, we have **39 active maintainers** across all repositories.

Whether fixing bugs, refining UI elements, updating documentation, or building entirely new integrations — every contribution matters.

# Highlights

As you might have already noticed in the activity statistics, there was much development on openHAB - too much to list everything.
Please refer to the [**release notes**](https://github.com/openhab/openhab-distro/releases/tag/5.0.0) to check out what's new and noteworthy (e.g. breaking changes).

In the following sections, our maintainers and contributors are introducing some new features you don't want to miss!

## Matter Integration

_Dan Cunningham ([@digitaldan](https://github.com/digitaldan)), openHAB Maintainer_

<p align="center"><img style="max-width: 75%; filter: drop-shadow(0 0 0.4em white)" src="/uploads/2025-07-21-openhab-5-0-release/matter-logo.svg"/></p>

### Matter: The Promise of Reliable, Secure and Locally Controlled Connectivity.

Matter is an open smart home standard from the [Connectivity Standards Alliance](https://csa-iot.org/all-solutions/matter/) that defines a robust IoT protocol that operates natively over IPv6, connecting Wi-Fi, Ethernet and low-power Thread devices over your local network without proprietary bridges or vendor clouds.
Major smart home companies like Apple, Google, Amazon, Samsung SmartThings, Signify (Philips Hue) and IKEA have invested significant resources jointly developing the Matter standard and have included Matter in nearly every device they ship.
With updates and additions to the Matter specification happening twice a year, Matter's adoption in the market is growing rapidly as it constantly adapts to support new devices, new use-cases and improves with feedback from users and vendors alike.

### openHAB Matter Client

<img src="/uploads/2025-07-21-openhab-5-0-release/matter-thing.png" class="img-beside-text-right" alt="Matter thing" />

openHAB 5.0 now features one of the most complete Matter 1.4.1 client implementations on the market — the [Matter binding](/addons/bindings/matter), which can communicate with more than 30 types of devices, from lights, locks and thermostats, to power meters, air quality sensors and robotic vacuum cleaners.
Matter Devices can be Wi-Fi or ethernet based, or they can be based on [Thread](https://www.threadgroup.org/), a low-power radio technology and successor to the ZigBee protocol which is baked into many recent consumer products like Apple TVs, Google Home Hubs, Amazon Echos as well as many Wi-Fi access points and routers.

One of the many strengths of Matter is that devices can be shared among different ecosystems, meaning a Matter device previously added to Apple Home or Google Home, can also be independently added to openHAB, who then talks directly to the device and not through a vendor's proprietary ecosystem.
openHAB can conversely share Matter devices as well, providing QR codes so other Matter clients can pair and talk directly to these devices.

Matter is quickly becoming the primary protocol used by IoT vendors, and with many companies like Ikea completely moving to Matter for all future devices, having a complete Matter implementation is crucial for any smart home system.

In the near future, Matter support will be coming to our mobile clients as well, allowing users to pair new Matter devices through a QR code without having to use a vendor-specific app.

<div style="clear:both;"></div>
But that's not all ...

### openHAB Matter Bridge

<img src="/uploads/2025-07-21-openhab-5-0-release/matter-bridge.png" class="img-beside-text-right" alt="Matter thing" />

A Matter "Bridge" is a part of the Matter standard that enables non-matter devices to speak the Matter protocol.
Bridges allow Z-Wave, ZigBee and other popular standards to interoperate with the Matter ecosystem by integrating a Matter server directly into existing hubs and controllers.
The Philips Hue hub, for example, provides a Matter bridge, as does the Ikea Dirigera, translating Matter to ZigBee or other protocols (and yes, openHAB can use Matter to talk with those ecosystems).

openHAB itself can now act as a Matter Bridge using a Matter development certificate (uncertified), exposing regular openHAB Items and Groups as Matter devices to third party clients like Alexa, Apple and Google, all while remaining local on the user's network.
This allows fast, secure and cloud-free control of openHAB from all major voice assistants as well as other third party Matter clients.
Exposing openHAB Items as Matter devices works similarly to how users currently tag Items for voice assistants like the [HomeKit add-on](/addons/integrations/homekit), or our [Alexa](/docs/ecosystem/alexa/) and [Google voice integrations](/docs/ecosystem/google-assistant/).
Users can use the Main UI to map Items to Matter device types, or use our standard text-based configuration.
Most standard Matter device types are supported, with more coming with every openHAB release.

<div style="clear:both;"></div>

### Special Thanks

Matter support would not be possible without the great work and collaboration from the [matter.js project](https://github.com/project-chip/matter.js), on which our implementation is based.

## Python Scripting

_Holger Hees ([@HolgerHees](https://github.com/HolgerHees)), openHAB Maintainer_

Our new major release introduces a new [Python Scripting add-on](/addons/automation/pythonscripting) based on [GraalPy](https://www.graalvm.org/python/).
Unlike the [Jython Scripting add-on](/addons/automation/jythonscripting), it offers full Python 3.11 support and is future-proof, as the underlying [GraalPy](https://www.graalvm.org/python/) is actively developed and promoted by Oracle.
In the long term, it will also completely replace the _outdated_ Jython add-on, but before, Jython will be marked as deprecated for a while.

The binding offers the possibility of using Python as a scripting language in UI or file-based rules, as well as in transformation services.
It also included a helper library that simplifies the use of openHAB's API and provides a more Pythonic interface to interact with openHAB's APIs.

It offers many improvements over the Jython binding, including:

- more convenient access to Items, Things & channels through the helper library
- a simplified way of creating and managing rules through the helper library
- support for native Python datatypes like [`datetype`](https://docs.python.org/3/library/datetime.html) instead of [`ZonedDateTime`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/ZonedDateTime.html)
- a dependency watcher that reloads scripts when dependencies change

The only current limitation is the lack of PIP support for installing external modules, which will be introduced in the next release.
If you don't want to wait, you can install [the beta version via the Marketplace](https://community.openhab.org/t/python-scripting-5-0-0-5-9-9/164947).

It's also important to note that this binding was not developed as a replacement for HABApp, which is completely independent, still actively developed, and enjoys a large community.
Your choice among these two options depends entirely on your personal preference.

## openHAB iOS App

<div class="img-beside-text-right">
  <img style="width: calc(33% - 7px);" src="/uploads/2025-07-21-openhab-5-0-release/screen-saver.gif"/>
  <img style="width: calc(33% - 7px);" src="/uploads/2025-07-21-openhab-5-0-release/ios-settings.png"/>
  <img style="width: calc(33% - 7px);" src="/uploads/2025-07-21-openhab-5-0-release/multiple-homes.gif"/>
</div>

_Dan Cunningham ([@digitaldan](https://github.com/digitaldan)), openHAB Maintainer_

The openHAB iOS app will soon receive a major update, including significant enhancements to its core code as well as introducing new features.

### Swift UI and Swift 6

Tim Bert ([@timbms](https://github.com/timbms)) has been hard at work upgrading the core of the app to modern versions of Swift, making the app easier to work on as well as taking advantage of modern language features to enhance performance and stability.
This is a major undertaking and helps ensure the longevity of our app.
This also includes a much-needed refreshed settings view, with additional configuration options for connections and a new logging UI.

### OpenAPI based Networking

Tim has also completely rewritten the networking to use Apple's OpenAPI Swift technology.
This modern approach generates all the required models and networking controllers directly from the openHAB OpenAPI published specifications, ensuring better conformity to our APIs, allowing faster development of new features, and ultimately providing a more consistent experience for users.

### Multiple "Home" Support

Tassilo Karge ([@TAKeanice](https://github.com/TAKeanice)) has contributed one of the most requested features to the iOS app, support for multiple homes!
Users can now have different preferences for their primary home, a vacation home, the office, etc... and quickly switch between them.
Even more impressive is that push notifications and iOS shortcuts are also multi-home-aware, selecting the correct home before performing an action.

### Kiosk Features

Many users like to use iPads or iPhones as kiosk devices, running the openHAB app in Apple's "Guided Mode", which locks the device to a single app.
Unfortunately, iOS lacks a built-in screen saver for always-on devices, which is not ideal for many situations.
The openHAB iOS app now features a robust embedded screen-saver with granular configuration options for everything from clock styles, fonts and sizes, to animation speeds and dimming settings.
Whether running as a wall mounted tablet, or as a nightstand clock, the openHAB app can more comfortably blend into your home environment.

## Core Runtime Enhancements

### YAML Configuration Format

_Laurent Garnier ([@lolodomo](https://github.com/lolodomo)), openHAB Maintainer_

openHAB 5.0 introduces a modular configuration system that allows supported entities to be defined in one or more YAML files.
While tags have been supported in YAML format since openHAB 4.1, this release adds support for defining Things and Items in YAML.
This new format does not replace our dedicated DSL format, but rather provides an alternative for YAML enthusiasts or users who have never been comfortable with our DSL syntax.
It is also a way to not depend too much on XTend/XText as we don't know how many more years these Eclipse projects will be maintained.
Unlike the DSL configuration files, YAML configuration files are not limited to a specific object type — they can contain any supported entities (Things, Items, Tags, etc.).

<details>
<summary>View example</summary>

```yaml
version: 1

tags:
  Location_Indoor_Room_HomeCinemaRoom:
    label: Home Cinema Room
    description: The room containing my home cinema system
    synonyms:
      - Home theater room
      - TV room
      - Movie room

things:
  lgwebos:WebOSTV:living-room:
    config:
      host: 192.168.2.119
      key: qwertz1234567890
      macAddress: 3c:cd:93:c2:20:e0

items:
  TV_Power:
    type: Switch
    label: TV Power
    icon: television
    autoupdate: false
    channel: lgwebos:WebOSTV:living-room:power
```

</details>

You can consult the [YAML Configuration Documentation](https://www.openhab.org/docs/configuration/yaml.html) for more details on the syntax and how to use it.

It is now also possible to generate this syntax directly from Main UI if you have Things and Items that were defined either with DSL syntax or created from Main UI, see [Copy DSL & YAML Definition: Connecting UI with Text Configuration](#copy-dsl-yaml-definition-connecting-ui-with-text-configuration).
Support for other entities will be added in the next releases, starting with rules and rule templates.
Other exciting features based on this are already in the pipeline.

### Semantic Tagging Enhancements

_Andrew Fiddian-Green ([@andrewfg](https://github.com/andrewfg)), openHAB Contributor_

openHAB 5.0 introduces a major overhaul of the semantic tagging system, which is now more powerful and easier to use than ever before.
This release includes the following enhancements:

- Clarified and extended rules and documentation for the use of semantic tags.
- Several new **_Equipment_**, **_Point_**, and **_Property_** tag constants to meet developer requests.
- Developer tools that ensure only correct semantic tags can be declared when bindings are added or modified.
- UI improvements to make it easier to visualise the semantic model and apply semantic tags to Items, see [Semantic Tags Maintenance & Treeview Picker](#semantic-tags-maintenance-treeview-picker) below.
- Semantic model validation checks warning about invalid semantic tag combinations, available from Main UI's health page and logged in the openHAB log on startup.

We have also made significant improvements to the default semantic tags applied by bindings, which now cover a much larger percentage of binding channel types and thing types:

- The number of **_Point+Property_** tag default values increased from under 3% to 40% of all bindings' channel types (or 81% of non-advanced channel types).
- The number of **_Equipment_** tag default values increased from zero to 74% of all bindings' thing types.
- Some bindings now apply **_Equipment_** and **_Point+Property_** tag default values dynamically depending on the actual attributes of Things and Channels in the Inbox. This further increases the tag coverage percentages above.

## Main UI Enhancements

_Florian Hotze ([@florian-h05](https://github.com/florian-h05)), openHAB Maintainer_

### Sitemap Editor Drag & Drop

<img src="/uploads/2025-07-21-openhab-5-0-release/sitemap-edit-dragdrop.gif" class="img-beside-text-right" alt="Sitemap Edit: Drag & Drop" />

When designing sitemaps through the UI, it was very cumbersome to move elements around, as you had to delete and re-add them in the desired order, or cut and paste the DSL code in the code tab.
With openHAB 5.0, we have introduced a drag and drop feature to the sitemap editor, allowing you to easily rearrange elements in the sitemap:

Many thanks to Mark Herwege ([@mherwege](https://github.com/mherwege)) for implementing this feature!

<div style="clear:both;"></div>

### Model Editor Drag & Drop

<div class="img-beside-text-right" style="display: flex; justify-content: space-between;">
  <img style="width: calc(50% - 3px);" src="/uploads/2025-07-21-openhab-5-0-release/model-dragdrop-1.gif"/>
  <img style="width: calc(50% - 3px);" src="/uploads/2025-07-21-openhab-5-0-release/model-dragdrop-2.gif"/>
</div>

Similarly to the sitemap editor, the model editor now supports drag and drop for moving semantic tags around.
This not only makes it faster to build your semantic model, it also makes it easier to ensure that your model is valid and follows the best practices by introducing numerous validation checks.

A big thank you to Mark Herwege ([@mherwege](https://github.com/mherwege)) for working on this game-changing feature!

<div style="clear: both;"></div>

### Regenerate Rules from Templates

_Ravi Nadahar ([@Nadahar](https://github.com/Nadahar)), openHAB Contributor_

Previously, rules created from rule templates were static and could not be updated if the template was changed.
It was necessary to delete and recreate the rules from the template to apply any updates or changes to the parameters used in the template.
openHAB 5.0 introduces a new feature that allows you to regenerate rules from templates, making it easier to keep your rules up to date with the latest changes in the templates.
This also allows you to change the parameters used in the template without having to delete and recreate the rules.

You can find more details in [the documentation](/docs/tutorial/rules_basic.html#update-a-rule).

### Copy DSL & YAML Definition: Connecting UI with Text Configuration

_Jimmy Tanagra ([@jimtng](https://github.com/jimtng)), openHAB Maintainer_

openHAB 5.0 introduces a convenient option for users who wish to convert their setup into text-based configuration.
Definitions of **Items** and **Things** can now be copied in **DSL** or the new **YAML** file format, making it easier to reuse, back up, or migrate content into textual configuration files.

This feature is intended purely as a convenience. Users can continue to rely entirely on the UI configuration if they prefer.

**Where you'll find it:**

- **Things list** and **Items list** – Select multiple entries to reveal a `Copy` button
- **Thing Details** and **Item Details** page – A `Copy File Definition` button is available at the bottom of the page
- **Things Inbox** – Clicking on an inbox entry — or selecting multiple entries — reveals a `Copy Thing File Definition` (or `Copy`) button. This lets you save discovered Things to a file-based configuration instead of importing them into the UI-managed database.
- **Developer Tools** – New menu options: `Things File Definition` and `Items File Definition` for one-click access

### State Series chart

_Jeff James ([@jsjames](https://github.com/jsjames)), openHAB Contributor_

<img class="img-beside-text-right" src="/uploads/2025-07-21-openhab-5-0-release/oh-state-series.png" alt="oh-state-series" />

In openHAB 5.0, we have added a new chart series type for time-based charts to easily see changes of an Item's state over time.
It is especially useful for Items that have a limited set of states, such as _ON_ and _OFF_, or _OPEN_ and _CLOSED_, but can also be used for Items with more complex states, such as _Air Temp State_ vs. _Air Temp_ in the example below.
The new [`oh-state-series`](/docs/ui/components/oh-state-series.html) supports several settings to adjust colour palette and the ability to provide a function to map item states (see _Air Temp State_ vs. _Air Temp_ in the example below).
This series can be used on any time-based chart with either an `oh-value-axis` or `oh-category-axis` as the y-axis.

<div style="clear:both;"></div>

### Semantic Tags Maintenance & Treeview Picker

<img src="/uploads/2025-07-21-openhab-5-0-release/semantic-tags-maintenance-picker.gif" class="img-beside-text-right" alt="Semantic Tags Maintenance & Picker" />

openHAB 4.1 introduced the ability to extend the semantic model with custom tags through a YAML configuration file.
In openHAB 5.0, we have added support for maintaining these custom tags through the UI.

The developer tools now include a new _Semantic Tags_ section, where you can view, edit, and delete your custom tags.
You can view tag relationships and structure at a glance, making it easier to understand the concept of the semantic model and how to use it effectively.
It features both a treeview and a code tab, allowing you to switch between a visual representation and the underlying YAML code.

In addition to the maintenance page, the semantics picker in the Item editor has been updated to use the treeview, making it easier to select the correct semantic tag for your Items by visualising the hierarchy of tags:

Again, a big thank you to Mark Herwege ([@mherwege](https://github.com/mherwege))!

<div style="clear:both;"></div>

### Additional Enhancements

- **Widget Config:** The widget config popup has been redesigned to support live updates, dirty checking and be movable, so you can watch the changes in your page while editing the widget config.
- **Specific Browser Titles:** The browser title now reflects the current page, making it easier to identify the contents of the openHAB tabs in your browser.
- **Log Viewer Enhancements:** The log viewer has been enhanced with a history buffer, allowing you to scroll back through previous log entries, and a log details popup that provides more information about each log entry.
  Additionally, a text mode has been introduced as alternative to the default table view, having the look and feel of the well-known [frontail](https://github.com/mthenw/frontail) log viewer.
- **Thing Inbox:** Add search, approve multiple Things at once and allow to change Thing ID & label when approving Things.

## Blockly Enhancements

- New Rule-Enable Block to enable or disable rules.
- New dictionary block to update dictionary entry values
- Persistence Block: Riemann sum support added
- Boolean-typed variable added
- Get Item Previous State added

## Basic UI Enhancements

- Basic UI now reloads the chart with higher resolution when clicking the zoom button instead of just upscaling the initial image.
- New Basic UI setting to choose how to display buttons: rectangular (default), rounded or pill-shaped.
- Basic UI now avoids shrinking the value of a `Text` element and instead shrinks the label.

## Add-on Enhancements

openHAB 5.0 brings 20 new add-ons, adding support for new devices:

- [AirParif Binding](/addons/bindings/airparif/): Integrates [AirParif](https://airparif.fr/) air quality and pollen data for the Paris area into openHAB.
- [Awtrix 3 Binding](/addons/bindings/mqtt.awtrixlight/): Controls the [Awtrix 3](https://blueforcer.github.io/awtrix3/) LED matrix display via MQTT, allowing to display notifications, weather, calendar events and more on the [Ulanzi Smart Pixel clock](https://www.ulanzi.com/products/ulanzi-pixel-smart-clock-2882).
- [Bambulab Binding](/addons/bindings/bambulab/): Integrates [Bambu Lab](https://www.bambulab.com/) 3D printers into openHAB, allowing to monitor and control print jobs.
- [Bluetooth Listener Binding](/addons/bindings/bluetooth.listener/): Allows to receive broadcasted data from Bluetooth devices without connecting to them, for example Bluetooth beacons.
- [CASO Binding](/addons/bindings/caso/): Integrates [Caso smart kitchen](https://www.caso-design.com/) devices into openHAB, allowing to control and monitor their wine coolers.
- [Ecoflow Binding](/addons/bindings/ecoflow/): Integrates [EcoFlow](https://www.ecoflow.com/) power stations and micro inverters into openHAB, allowing to monitor and control power usage.
- [Emby Binding](/addons/bindings/emby/): Integrates [Emby](https://emby.media/) media server into openHAB, allowing to control playback and monitor media status.
- [Fronius Wattpilot Binding](/addons/bindings/froniuswattpilot/): Integrates [Fronius Wattpilot](https://www.fronius.com/en/solar-energy/home-owners/products-and-solutions/e-mobility) EV chargers into openHAB, allowing to monitor and control charging sessions.
- [IKEA DIRIGERA Binding](/addons/bindings/dirigera/): Integrates the [IKEA DIRIGERA](https://www.ikea.com/de/en/p/dirigera-hub-for-smart-products-white-smart-10503406/) gateway into openHAB, allowing control and monitoring of IKEA smart home devices.
- [LG ThingQ Binding](/addons/bindings/lgthingq/): Integrates LG ThingQ-compatible devices into openHAB, allowing control and monitoring of LG smart home devices such as air conditioners, washing machines, and refrigerators.
- [Matter Binding](#matter-integration): Seamlessly integrates Matter devices into openHAB, allowing to control and monitor them without vendor-specific apps or cloud services, and allows to expose openHAB Items as Matter devices, enabling control from third-party Matter clients like Apple Home, Google Home and Amazon Alexa.
- [Meross Binding](/addons/bindings/meross/): Integrates [Meross](https://www.meross.com/) smart ambient lights and smart plugs into openHAB.
- [Ondilo Binding](/addons/bindings/ondilo/): Integrates [Ondilo ICO Pool and Spa monitoring devices](https://ondilo.com/en/), allowing to monitor and automate a pool environment.
- [OpenAI TTS Voice](/addons/voice/openaitts/): Integrates the [OpenAI TTS](https://platform.openai.com/docs/guides/text-to-speech) service into openHAB, allowing to use OpenAI's text-to-speech capabilities for voice announcements and notifications.
- [Python Scripting](#python-scripting): A new scripting add-on based on GraalPy, offering full Python 3.11 support and a more Pythonic interface to interact with openHAB's APIs.
- [Ring Binding](/addons/bindings/ring/): Integrates [Ring](https://ring.com/) devices, such as cameras, doorbells and others, into openHAB.
- [SBus Binding](/addons/bindings/sbus/): Integrates SBus devices into openHAB, allowing control and monitoring of SBus-compatible devices over UDP.
- [Sense Energy Binding](/addons/bindings/senseenergy/): Integrates the [Sense Energy monitor](https://sense.com/) into openHAB, providing accurate energy usage statistics and insights.
- [Tuya Binding](/addons/bindings/tuya/): Integrates Tuya Wi-Fi devices into openHAB, allowing control and status monitoring on the local network.
- [Z-Wave JS Binding](#z-wave-js-binding): Connects to an external [Z-Wave JS](https://zwave-js.github.io/zwave-js/) server, providing an alternative way to integrate Z-Wave networks into openHAB.

But not only were new bindings added, some existing bindings also received massive improvements:

- The [Amber Electric Binding](/addons/bindings/amberelectric/) adds support for energy price forecasts.
- The [Fronius Binding](/addons/bindings/fronius/) extends support for controlling the battery connected to Symo Gen24 Plus inverters.
- The [Grundfos Alpha Binding](/addons/bindings/bluetooth.grundfosalpha/) adds support for the Grundfos Alpha 3 circulator pump with built-in Bluetooth.
- The [Insteon Binding](/addons/bindings/insteon/) adds support for new devices, enhances debugging capabilities, and fixes several bugs.
- The [Shelly Binding](/addons/bindings/shelly/) adds support for various new Shelly devices, including Shelly Plus 2PM Gen3, BLU Gateway Gen3, Gen4 devices, and includes many bug fixes.

### Z-Wave JS Binding

_Leo Siepel ([@lsiepel](https://github.com/lsiepel)), openHAB Maintainer_

The openHAB 5.0 release introduces a new [Z-Wave JS binding](/addons/bindings/zwavejs), offering an alternative way to integrate Z-Wave networks into openHAB by connecting to an external [Z-Wave JS](https://zwave-js.github.io/zwave-js/) server.
This binding is particularly useful for advanced users, large networks, or those seeking cross-platform compatibility—such as when migrating from or running alongside other home automation platforms.
It supports newer 700/800 series chipsets, S2 security, Smart Start, and provides more robust device management features.
While the binding does not yet expose every capability of [Z-Wave JS](https://zwave-js.github.io/zwave-js/) (such as NVM backups), these can be accessed via the [Z-Wave JS UI](https://zwave-js.github.io/zwave-js-ui/) directly.
Importantly, the existing native Z-Wave binding remains fully supported, giving users the flexibility to choose the integration that best fits their needs.

More information and discussion can be found on the community forum:

- [New Z-Wave JS binding released](https://community.openhab.org/t/new-z-wave-js-binding-released/164943)
- [Z-Wave JS UI in place of openHAB Z-Wave binding](https://community.openhab.org/t/zwave-js-ui-in-place-of-oh-zwave-binding/150007)

### MQTT Home Assistant Binding

_Cody Cutrer ([@ccutrer](https://github.com/ccutrer)), openHAB Maintainer_

On the subject of Python, the GraalVM work has enabled the Home Assistant MQTT binding to switch from using the Java Jinjava library for emulating Python's Jinja to actually running Python and Jinja.
This allows openHAB to import some of the actual Home Assistant Python code, so template rendering from devices should be near-perfect, without constantly playing a game of catch-up as we find devices that use some feature of Python, Jinja, or Home Assistant that we hadn't previously conceived of.

We've also taken this one step further, and re-implemented parsing of the Home Assistant JSON discovery metadata via Home Assistant's own classes, which fixes myriad strange bugs and incompatibilities from attempting to implement in Java using only Home Assistant documentation as a guide.
We now get the benefit of exactly matching many of those minor idiosyncrasies that aren't documented.
There's still work to do in the portion of the binding that connects incoming data to openHAB channels.
However, it's now sitting on a much stronger base so that any issues there can be more quickly iterated on and fixed.

## openHABian Enhancements

The new openHABian v1.10.x series has been released in preparation for the openHAB 5.0 release, adding support for Java 21, updating the underlying base OS and bringing many bug fixes and improvements.

Check out the [release notes](https://github.com/openhab/openhabian/releases/tag/v1.10.3) for more details.

# Enjoy and Get in Touch!

We are excited to see what you will do with the new features and improvements in openHAB 5.0 — your feedback is always welcome!
As always, our [community forum](https://community.openhab.org/) is there for questions, comments and discussions.
Do not hesitate to get in touch, join our community, receive help and share your experiences and use cases.
