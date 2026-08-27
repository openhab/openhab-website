---
layout: BlogPost
category: blog
title: openHAB 4.2 Release
author: Florian Hotze and others
date: '2024-07-07T18:00:00+02:00'
previewimage: /uploads/2024-07-07-openhab-4-2-release/header.png
tags:
  - news
excerpt: >-
  One year has passed since our big openHAB 4.0 release, and we are thrilled to announce our first summer minor release of the openHAB 4.x series&colon; openHAB 4.2.
  openHAB 4.2 adds a number of exciting new features, including some long awaited notification enhancements, as well as a multitude of smaller improvements and bug fixes.
---
One year has passed since our big [openHAB 4.0 release](/blog/2023-07-23-openhab-4-0-release.html), and we are thrilled to announce our first summer minor release of the openHAB 4.x series: openHAB 4.2.
openHAB 4.2 adds a number of exciting new features, including some long awaited notification enhancements, as well as a multitude of smaller improvements and bug fixes.

With that being said, we as usual want to share our highlights and some statistics that show the activity in numbers.

# Activity

As you'd expect from any new openHAB release, we have had a high activity across all our GitHub repositories.
We therefore want to share a few statistics about our three main repositories: Core, add-ons and UIs.

[openHAB Core](https://github.com/openhab/openhab-core) has received 216 pull requests in total, with 56 bug fixes and 104 enhancements resulting in 11,160 lines of added code.

23 new add-ons, 158 bug fixes and 195 enhancements were contributed in 572 pull requests to the [openHAB add-ons repository](https://github.com/openhab/openhab-addons), which resulted in the addition of 298,936 lines of code.

The [openHAB web UIs](https://github.com/openhab/openhab-webui) have broken their "personal" best with a whopping 247 merged pull requests, including 95 bug fixes and 105 enhancements resulting in 32,761 lines of code changes.

It is worth to mention, that [our other repositories](https://github.com/openhab) have also received numerous contributions (e.g. documentation), but listing them all would probably be too much here.
Many thanks to all our contributors for driving openHAB forward!

Again, it is time to shout out to our top code contributors per repository (having done the most commits) for this new release:

- Wouter ([@wborn](https://github.com/wborn)) for openHAB core
- Holger ([@holgerfriedrich](https://github.com/holgerfriedrich)) for openHAB core
- Jan ([@J-N-K](https://github.com/J-N-K)) for openHAB core
- Jacob ([@jlaur](https://github.com/jlaur)) for openHAB add-ons
- Holger ([@holgerfriedrich](https://github.com/holgerfriedrich)) for openHAB add-ons
- Florian ([@florian-h05](https://github.com/florian-h05)) for the openHAB Main UI
- Jimmy ([@jimtng](https://github.com/jimtng)) for the openHAB Main UI
- Laurent ([@lolodomo](https://github.com/lolodomo)) for the openHAB Basic UI

Many of our top committers are also maintainers, which means besides contributing code, they also review pull requests and participate in discussions on GitHub issues, which helps maintain our high level of quality across bindings, UIs and Core.
At present, we have 36 maintainers across all our repositories.
Huge thanks to all of them for keeping a high development pace for openHAB 4.2!

# Highlights

As you might have already noticed in the activity statistics, there was much development on openHAB - too much to list everything.
Please refer to the [**release notes**](https://github.com/openhab/openhab-distro/releases/tag/4.2.0) to check out what's new and noteworthy (e.g. breaking changes).

In the following sections, our maintainers and contributors are introducing some new features you don't want to miss!

## Mobile Notification Enhancements

_Dan Cunningham ([@digitaldan](https://github.com/digitaldan)), openHAB Maintainer_

With openHAB 4.2 we have updated our mobile push notifications architecture, bringing modern, cutting edge notification features to both our Android and iOS clients.

First, we have consolidated both mobile platforms to use Google Firebase Messaging, which greatly improves the reliability of push notifications from our cloud service and reduces the amount of work needed to add new features in a cross-platform way.

This change has allowed us to add an incredible amount of new features to our app in a relatively short amount of time.

### Notification Display Enhancements

Notifications now contain many more additional features, such as:

- Title
  - Replaces the default "openHAB" text with a user supplied version
- Media Attachments
  - Add images (or a short video on iOS) from an external URL or openHAB image item
- On Click Action
  - Navigate to a specific sitemap, page, popup widget, etc... in our UIs when the notification is clicked
- Action Buttons
  - Add up to 3 buttons that allow for executing commands, navigating through our UI's or open links in an embedded browser

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/notifications.png"/></p>

### Update / Collapse Notifications

We have also added some really useful ways to manage notifications already pushed to a device through rules and actions!

- Collapsible Notifications
  - Instead of seeing 100 messages that you left the garage door open, have a new message replace the existing one shown, so only the latest message is visible on a user's device.
  - Update existing messages with new information, add additional actions, updated media, etc.. without showing multiple notifications.

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/collapse-notifications.png"/></p>

### Remove / Hide Notifications

Finally, this has been a long requested feature by users, so we are very excited to be able to support removable notifications in this release!

- Hide / Remove Notifications
  - Is an alert no longer valid? Need to display something only temporarily?
  - Using rules or actions, you can remove already pushed notifications from your devices.

### Scripting Language Support

These new notification enhancements are of course available across all our rule languages, but we have introduced additional helper APIs in our [JavaScript Scripting](/addons/automation/jsscripting/#cloud-notification-actions) and [JRuby Scripting](https://openhab.github.io/openhab-jruby/main/OpenHAB/Core/Actions/Notification.html) implementations to make this even easier to use.

### Android Client Availability

Keep on the lookout for an update to our Android client to support these awesome new features in the coming days and weeks.

<a href="https://play.google.com/store/apps/details?id=org.openhab.habdroid"><img src="https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png" alt="Get it on Play Store" height="80"></a>

### iOS Client Availability

It's been a long time since we have pushed an official update to the iOS app.
Unfortunately we have been unable to push updates do to a technical issue with one of our app store identifiers that Apple has not been able to resolve.
After months of back and forth with Apple's developer support team, we have decided to move forward with an alternative plan to release a brand-new app.

Our new iOS app will still be called "openHAB" and will include all of great notification features mentioned above as well as more than a year's worth of bug fixes and improvements along with the Apple Watch companion app.
The new openHAB iOS app will require at least iOS 16 and will drop openHAB 1.x support.

The existing app will continue to function, but be renamed to "openHAB V1".
This "legacy" app will only receive security updates and critical fixes, but will support openHAB 1.x to at least 4.2 and will also work for devices running iOS 15 and earlier.
The legacy app will not include Apple Watch support nor support our new enhanced notifications features, although basic notifications will continue to be supported.

Once both apps are available in the app store, the legacy app will prompt users to upgrade and make the switch.

In the meantime, you can download our new app right now on [TestFlight](https://testflight.apple.com/join/0uFYONeF) and try out these amazing new features!

<a href="https://testflight.apple.com/join/0uFYONeF"><img src="https://developer.apple.com/assets/elements/icons/testflight/testflight-128x128_2x.png" width="75" alt="Download on TestFlight"></a>
Download the new openHAB app on [TestFlight](https://testflight.apple.com/join/0uFYONeF).

Many thanks to:

- Florian Hotze ([@florian-h05](https://github.com/florian-h05)) for the enhanced JavaScript Scripting language support, docs, and code reviews of the cloud connector add-on.
- Jimmy Tanagra ([@jimtng](https://github.com/jimtng)) for the enhanced JRuby Scripting language support.
- Our app maintainers [@mueller-ma](https://github.com/mueller-ma), Danny Baumann ([@maniac103](https://github.com/maniac103)), [@weakfl](https://github.com/weakfl) and Tim Bert ([@timbms](https://github.com/timbms)) for all their work on the mobile apps!

## Java 21 Support

_Holger Friedrich ([@holgerfriedrich](https://github.com/holgerfriedrich)), openHAB Maintainer_

Java 17 is required and still recommended for all openHAB 4.x releases.
But with version 4.2, we introduce Java 21 as an alternative:

We typically focus on Java releases with long-term support (LTS) and the next LTS release following after Java 17 is Java 21, released in 2023.
To allow compiling openHAB with Java 21, we had to adapt our toolchain, upgrade dependencies, and also introduce some code changes.
This resulted in a comprehensive upgrade of almost all dependencies used in core, including Karaf and Xtext/Xtend.
To allow for running openHAB with Java 21, a few more changes had to be introduced:
One notable difference between Java 17 and Java 21 is the change of the serialization format of DateTime in [CLDR 42](https://cldr.unicode.org/index/downloads/cldr-42), which required some extra efforts in persistence to allow switching the Java version in an existing installation.

Now you can use both Java 17 and Java 21 to run openHAB, but the openHAB distribution continues to use the Java 17 binary format which can run on both Java versions.
Please consider Java 21 support as experimental, as it has not been tested thoroughly yet.
Also note that Java 21 is only available for 64-bit systems.
If you use openHABian and have installed the 64-bit image, you can install Java 21 using `openhabian-config`.

Developers can even choose between three options:
Java 17, Java 21 creating Java 17 binaries (default for openHAB if you use Java 21), and native Java 21 (binaries will not work on a Java 17 server).
Whereas we recommend Java 17 for running openHAB, development can be safely done on Java 21.

Please refer to the [developer documentation](/docs/developer/#setup-the-development-environment) for more information.

## Core Runtime Enhancements

### Persistence Extensions

_Mark Herwege ([@mherwege](https://github.com/mherwege)), openHAB Contributor_

Persistence Extensions have allowed the different scripting languages to easily persist states and retrieve persisted states or values calculated from these persisted states for a long time.

As openHAB supports units of measurument (UoM), persistence services can also return persisted values with a unit of measurement.
However, the Persistence Extensions did not consider these units of measurement and returned just a decimal value as the result of their calculations.
With openHAB 4.2, Persistence Extensions have been enhanced to also return the unit of measurement.
This allows rules and scripts to simply calculate with `QuantityType`s without any implicit or explicit conversion to a `DecimalType`, while keeping the results consistent if different units of measure are used.
Note that this change may require adapting previous rules.

With the introduction of [Time Series support](/blog/2023-12-22-openhab-4-1-release.html#time-series-support-for-forecasts-and-historical-values) in openHAB 4.1, persistence services were extended to allow storing future values and forecasts.
openHAB 4.2 extends the Persistence Extensions to allow persisting future states and retrieving future values.
All persistence data retrieval methods now have `last`, `next` and `between` variants, 
whereby `last` will use the period from a point in time in the past until now, `next` will use the period from now to a future point in time and `between` will use the period between two provided points in time in the past and/or future.

To allow storing multiple values to persistence in one go, Persistence Extensions methods now support working with Time Series instead of individual values when persisting or retrieving data.
Time Series are series of time/value pairs, and can be constructed in rules, e.g. by modifying a Time Series retrieved from another persistence service or another Item.

Also, there was no way before to retrieve the time of the last state change for an item from persistence.
The existing methods (`previousState()` or `previousState(true)`) would not give the right result if the same value had been persisted multiple times.
A new method `lastChange()` has been added to resolve this.

Scripting languages (Rules DSL, JavaScript, jRuby and Blockly) have implemented full support of these new and enhanced Persistence Extensions, please refer to the individual languages' documentation for more information.

As much has changed, it is worthwhile to read the [documentation](/docs/configuration/persistence.html#persistence-extensions-in-scripts-and-rules) to update your knowledge about openHAB persistence extensions and learn everything about the new features.

### Default State Presentation Pattern

_Laurent Garnier ([@lolodomo](https://github.com/lolodomo)), openHAB Maintainer_

A default state pattern is now provided for String, Number and DateTime Items, whether the Item is linked to a channel or not.
It is used when no other pattern is provided by any other means (channel, metadata, ...).
There is no need to set the state pattern explicitly, unless the default does not match your wish.

Here are the respective defaults:

- for String Items: `%s`
- for DateTime Items or groups with DateTime state: `%1$tY-%1$tm-%1$td %1$tH:%1$tM:%1$tS`
- for Number Items or groups with number state: `%.0f`
- for Number Items with dimension or groups with number with dimension state: `%.0f %unit%`

## Main UI Enhancements

_Florian Hotze ([@florian-h05](https://github.com/florian-h05)), openHAB Maintainer_

### Dependency & Build System Upgrades

openHAB 4.2 upgrades most of Main UI's dependencies to their latest version, including the charting engine [Apache ECharts](https://echarts.apache.org) and the date and time manipulation library [dayjs](https://day.js.org).
As Main UI is still using Vue 2, we would like to upgrade to Vue 3 in the future - by upgrading to the latest Vue 2.x version, we have taken a minor step towards Vue 3.

In addition to our runtime dependencies, we have also upgraded our build system to the latest tooling: Webpack 5 and Node.js 20.
This ensures we can always use the latest Webpack features when bundling the Main UI source code, and moves away from Node.js 16, which is now EOL.

Many thanks to Miguel Álvarez ([@GiviMAD](https://github.com/givimad)) for the Webpack upgrade!

### Semantic Model Templates

_Justin Georgi ([@justingeorgi](https://github.com/JustinGeorgi)), openHAB Contributor_

It has gotten even easier for first time users of openHAB to get started quickly.

Instead of building up the organization of a home one location at a time, users creating a new semantic model can take advantage of the new template wizard to create a structured semantic model with just a few clicks.
The model template page provides three basic base templates with the ability to quickly select the necessary combination of rooms followed by one click creation of all the semantic items:

- One Bedroom Apartment
- One Story House
- Two Story House

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/semantic-model-template.png"/></p>

### Persistence Settings Menu

Persistence configuration through the UI has been [supported since openHAB 4.0](/blog/2023-07-23-openhab-4-0-release.html#persistence-configuration), but unfortunately it was hidden in the add-on settings and difficult to find.

This finally changes with openHAB 4.2 with the introduction of the new persistence settings menu:

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/persistence-menu.png"/></p>

The new page is reachable through the settings menu and allows to configure the default persistence service, persistence policies and installation of more persistence add-ons.

Thanks to Mark Herwege ([@mherwege](https://github.com/mherwege)) for the contribution!

### Item Form Enhancements

_Jimmy Tanagra ([@jimtng](https://github.com/jimtng)), openHAB Maintainer_

Items are one of the core elements in an openHAB system.

To make viewing and editing them easier and more streamlined, the Item Form has received some minor cosmetic and functional improvements, e.g. easier managing of parent groups.

For `Number` Items with a dimension (UoM Items), it is now easier to set the Item's unit directly on the form with a default unit pre-filled, thanks to the work by Mark Herwege ([@mherwege](https://github.com/mherwege)).
The unit defaults to the default system unit for the configured measurement system, and a dropdown allows to select from common alternatives or to enter a custom unit.
Bindings may propose a default unit for channels, which will be used when the Item is created from a channel.

### Add-on Store Redesign

_Jimmy Tanagra ([@jimtng](https://github.com/jimtng)), openHAB Maintainer_

The Add-on Store has been split up into sub-sections on navigation sidebar according to the add-on types.
When the navigation sidebar is not available, e.g. on mobile, the Add-on Store will split up into tabs according to the add-on categories.

The main Add-on Store page now shows the list of all suggested and installed add-ons, grouped by type, for a quick overview.
The add-on type sub-pages show the suggested add-ons on top, followed by the available add-ons.

The search box on the main Add-on Store page allows searching through all add-ons in every category, whereas the search box on the add-on types' sub-pages searches only the add-ons of the selected type.
In addition to that, filters were introduced to filter the add-ons by their connection type (e.g. cloud allowed, no cloud allowed) and country (all applicable for you, only for your country, all) (thanks to Mark Herwege ([@mherwege](https://github.com/mherwege))).

Browsing through the Add-ons Store and switching through the different sections is now much faster, thanks to cached results.
This makes browsing and installing add-ons through the UI easier and quicker.

The new Add-on Store sidebar menu and main page looks like this:

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/add-on-store.png"/></p>

### Setup Wizard Extensions

With the introduction of [add-on suggestions](/blog/2023-12-22-openhab-4-1-release.html#add-on-suggestions) in openHAB 4.1, we made a first, big step towards a better first-user experience.

openHAB 4.2 continues this path by extending the setup wizard with a separate step for persistence.
In this step, suggested persistence add-ons are displayed together with a short explanation for the suggestion.
The user can then decide if he wants to install the suggested persistence add-ons or not, and install more add-ons in the next step:

<div align="center" class="row">
  <img style="max-width: 35%;" src="/uploads/2024-07-07-openhab-4-2-release/setup-wizard-persistence.png"/>
  <img style="max-width: 35%;" src="/uploads/2024-07-07-openhab-4-2-release/setup-wizard-addons.png"/>
</div>

Many thanks to Mark Herwege ([@mherwege](https://github.com/mherwege)), who already worked on the add-on suggestions in openHAB 4.1, for this enhancement!

### `oh-context` Component

_Justin Georgi ([@justingeorgi](https://github.com/JustinGeorgi)), openHAB Contributor_

With openHAB 4.2, advanced custom widgets have gotten more powerful with the new `oh-context` component!

This component allows widget authors to insert a code context block at any point in the widget tree and define three different types of objects available for use in expressions in all children of the `oh-context`:

- Variables: These context variables differ slightly from the normal widget variables in that they can have initial default values and also have complete communication with sub-widgets.
- Constants: Context constants make for much more concise and readable expressions but unlike variable are only evaluated once when the widget loads.
- Functions: Named context functions allow widget authors to efficiently reuse complex functions in multiple expressions.

Please have a look at the [documentation](/docs/ui/widget-expressions-variables.html) to learn about the new `oh-context` component.

### Health UI

Ever heard of orphaned links before? Orphaned links are channel links, where either the Item or the channel (or possibly even both) are missing.

As you can imagine, orphaned links can and should be removed.
The new health UI allows to easily check if there are orphaned links and take care of them:

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/health-menu.png"/></p>
<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/health-orphan-links.png"/></p>

If there are health issues, the UI will be available through a floating action button (FAB) shown on the settings menu page.
This FAB looks similar to the Thing Inbox button on the Things list.
If there are no health issues, the FAB will not be shown and you won't have access to the health UI.

The health UI is not only meant to display orphaned links, but also to provide a central place for health checks and maintenance tasks.
So stay tuned what gets added in the future!

Thanks to Arne Seime ([@seime](https://github.com/seime)) for this nice addition!

## Blockly Enhancements

_Stefan Höhn ([@stefan-hoehn](https://github.com/stefan-hoehn)), Blockly Maintainer_

<p align="center"><img style="max-width: 70%;" src="/uploads/2024-07-07-openhab-4-2-release/blockly.png"/></p>

There is a huge amount of new features for Blockly, which is why only a quick overview is provided here.
For a detailed explanation of every new feature, see the [community post of May 30](https://community.openhab.org/t/blockly-whats-new-since-openhab-4-0/156275).

### Blockly Upgrade

Thanks to Jimmy ([@jimtng](https://github.com/jimtng)), Blockly has been upgraded from v9.2.0 to v10.4.2 which didn’t directly bring some real fancy stuff for you as a user but is something I didn’t dare to do (openHAB 4.0 did a major Blockly version increase though). 

### Blockly Style Selection

Blockly comes in different “design flavors” and again this is something that Jimmy added to our Blockly implementation which is not so obvious in the first place.

### Typed Variables

_The most important Blockly change_ was just released very lately and is about **variables that can have a type**.
Until now Blockly only provided untyped variables. 
Even though this seems to be more straight forward and provides the flexibility to put any type into that variable, it creates some challenges to openHAB Blockly to generate the right code.

Most blocks in Blockly have input and output types defined which allows the editor to check whether one particular block can be used as an input for a different block. 
This becomes challenging with the standard untyped variables because the type of these is basically -unknown- which means that the Blockly editor is not able to check whether this block is allowed or not to be added at that particular position.
This even more is a challenge when Blockly tries to generate the right code, because code generation relies on knowing the type of the input blocks.
Until know, Blockly was assuming some default type when it was not able to detect the input type, which however could have resulted in the generation of incorrect code.

Therefore, a new “typed variable” section was introduced.
**From now on always prefer Typed Variables over normal Variables!**

When you create a variable, you can give the variable a type and then use that typed variable and magically Blockly will create the right code.

### Adjust persistence blocks to breaking changes & extend them

We normally hate to break things and in this case Blockly didn't actually break something, but openHAB Core [changed the persistence extensions](#persistence-extensions), these now also allow to access future values and persist Time Series, like a weather forecast. 
This led to a major API changes which requires Blockly to generate different code.
Thanks to Mark ([@mherwege](https://github.com/mherwege)) for extending the persistence blocks to support these new features.

_In case you have used historic data with persistence you need to migrate your Blockly code_ which is as ease as opening the rule that contains a persistence block with historic data and then just save it. That’s everything.

### HTTP block

For a long time a block was missing to allow making HTTP requests, but with openHAB 4.2 we finally introduce a new block that supports sending HTTP requests. 
Even though this block already has much functionality, more improvements on URL encoding and parameter support are coming soon.

### Thing Extensions

The Thing block happened to be a rather limited one that was missing the ability to retrieve information about a Thing, and it also wasn't possible to iterate over the Things. 
These features have now become available and in particular with the typed variables they are now very convenient to use.

### Timer Context Extension

This addition is about providing a context to the statement block of a timer.
Timers provide a statement block where the blocks reside that are run when the timer triggers.
The context allows data to be provided to the statement blocks, which allows to pass immutable data to the statement blocks instead of referencing mutable data from the context where the timer is created

### Math and Logic Extensions

New Blocks were added for getting Min/Max, parsing a Number and representing `undefined`.

## Sitemap Enhancements

_Laurent Garnier ([@lolodomo](https://github.com/lolodomo)), openHAB Maintainer_

### Two possible behaviors for the Slider element

A new parameter named `releaseOnly` was added to the `Slider` element.
If `releaseOnly` parameter is specified, the new value is only sent on releasing the slider.
Otherwise values are sent while sliding which is now the default behavior.

Note: an implicit slider element (when `Default` element is used) will have the `releaseOnly` parameter set.
Its behavior is therefore to send the new value only when the slider is released.

### Press and release buttons

For a `Switch` element with mappings, each button can now behave either as a click button or as a press and release button.
The default behavior is a click button.
To get a press and release behavior, provide two commands separated by a colon.
The first command is sent to the item when the button is pressed and the second command is sent when the button is finally released.
Here is an example of such a button sending command ON when the button is pressed and command OFF when the button is released.

```java
Switch item=myItem mappings=[ON:OFF="On"]
```

### Extended chart periods to cover past and future

The time axis can now be either entirely in the past ending at the present time, entirely in the future starting at the present time, or partly in the past and partly in the future around the present time.
To do this, the value of the `period` parameter can now be composed of two parts separated by the "-" character, the value before the "-" is then the scale in the past and the value after the "-" is the scale in the future.
Valid values before and after the central character "-" are `h, 2h, 3h, ..., D, 2D, 3D, ..., W, 2W, 3W, ..., M, 2M, 3M, ..., Y, 2Y, ...` and any valid duration following the ISO8601 duration notation such as `P1Y6M` for the last year and a half or `PT1H30M` for the last hour and a half.
If only a period is provided, i.e. without the final "-" character or without anything after the "-" character, only a period in the past is taken into account.

### New Button element

A new `Button` element was introduced.

```java
Button item=<itemname> [label="<labelname>"] [icon=<iconref>] [staticIcon=<iconref>] row=<row> column=<column> [stateless] click=<cmd> [release=<cmd>]
```

Such an element is only accepted as a child of a `Buttongrid` element.
It adds more functionalities to buttons in `Buttongrid` than before in openHAB 4.1.
You can now choose between stateful or stateless behavior and between click or press & release behavior.
Icon can be dynamic by defining icon conditions.
Label and icon color can be dynamic using the `labelcolor` and `iconcolor` parameters.
Visibility of the button can be dynamic using the `visibility` parameter.

## Basic UI Enhancements

_Laurent Garnier ([@lolodomo](https://github.com/lolodomo)), openHAB Maintainer_

In addition to the implementation of all the new sitemap features described in the previous chapter, the major fix in this version concerns the `Slider` element.
In previous releases, the slider did not work reliably and differently depending on used web browser - this is now finally fixed.

The major change of this release is the introduction of a new settings page inside Basic UI:

<p align="center"><img style="max-width: 40%;" src="/uploads/2024-07-07-openhab-4-2-release/basicui-settings.png"/></p>

Previously, Basic UI settings were adjustable in Main UI only and the same regardless of the used client.
In contrast to that, these settings are now accessible directly in Basic UI and stored on the client (browser).
So the user can now have different settings on a phone and on a PC for example.
The new page can be accessed by clicking the settings icon at the top left on the sitemap list page and on the home page of any sitemap.

Basic UI theme now matches the dark mode of Main UI.
It can be updated either in Main UI or in Basic UI.

Web Audio support can also be enabled either in Main UI or Basic UI.

New settings were also introduced, such as a setting to use a bigger font size or settings to control the chart size and the size of content (text, line) in the chart.
Only two settings remain in Main UI because they are server dependent and not client dependent.

Here are the other main changes:

- `Switch` element rendered with buttons: the value to the right of the buttons is now only displayed if a state pattern is defined on the element. This value is therefore not displayed by default.
- `Switch` element rendered with buttons: the buttons are now arranged on multiple lines if there is not enough place on one line. This avoids having buttons overriding on the next column.
- `Chart` element: the list of predefined periods you can select now contains past and future periods.
- The "none" icon no longer triggers a request to the server.
- User-defined colors (`labelcolor`, `valuecolor` and `iconcolor` parameters) are now automatically adjusted to the current theme for better contrast, the same way the Android app does. This is the default behavior but an application setting has been added to disable this adjustment.

## Add-on Enhancements

openHAB 4.2 brings 23 new add-ons, adding support for new devices:

- The [AirGradient binding](/addons/bindings/airgradient) supports AirGradient air quality sensors.
- The [Amber Electric binding](/addons/bindings/amberelectric) provides access to the Australian energy retailer's Amber API with energy pricing and renewable energy data.
- The [ArgoClima binding](/addons/bindings/argoclima) for ArgoClima HVAC devices.
- The [Basic Profiles transformation](/addons/transformations/basicprofiles), which provides a list of useful profiles and transformations.
- The [CP750 binding](/addons/bindings/cp750) to communicate with a CP750, a common sound processor used in cinemas.
- The [Emotiva binding](/addons/bindings/emotiva) integrated Emotiva AV processors using the Emotiva Network Remote Control protocol.
- The [Ephemeris binding](/addons/bindings/ephemeris) which provides access to openHAB Core's Ephemeris feature through Items.
- The [Freeathome binding](/addons/bindings/freeathome) is a new binding for controlling free@home devices from ABB / Busch-Jaeger.
- The [Freecurrency binding](/addons/bindings/freecurrency) allows converting between different currencies and makes full use of the UoM currency capability.
- The [French Government Energy Data binding](/addons/bindings/frenchgovtenergydata) provides regulated electricity prices in France.
- The [GridBox binding](/addons/bindings/gridbox) for connecting to the Viessmann GridBox.
- The [Growatt binding](/addons/bindings/growatt) for Growatt solar inverters.
- The [IoTaWatt binding](/addons/bindings/iotawatt) integrated IoTaWatt Open WiFi Electric Power Monitor into openHAB.
- The [MfFan binding](/addons/bindings/mffan) enables communication between openHAB and "Modern Forms" or "WAC Lighting" WIFI connected, smart, ceiling fans.
- The [PanasonicBDP](/addons/bindings/panasonicbdp) for Panasonic Blu-ray players.
- The [PegelOnline binding](/addons/bindings/pegelonline) allows to observe water levels from German rivers.
- The [RadioBrowser binding](/addons/bindings/radiobrowser) to navigate and find internet radio broadcasts.
- The [Saicismart binding](/addons/bindings/saicismart) supports reading out vehicle data of cars running the iSMART system from SAIC.
- The [Salus binding](/addons/bindings/salus) facilitates seamless integration between openHAB and Salus Cloud.
- The [SiemensHVAC binding](/addons/bindings/hvac) provides support for the Siemens HVAC controller ecosystem, and the Web Gateway interface OZW672.
- The [Solar Forecast binding](/addons/bindings/solarforecast) to interface two different free photovoltaic forecast services.
- The [Sungrow binding](/addons/bindings/sungrow) is a Modbus binding that integrates Sungrow inverters.
- The [TeslaPowerwall binding](/addons/bindings/teslapowerwall) enables the capture of key data from a Tesla Powerwall 2 into openHAB.
- The [Whisper Speech-to-Text voice add-on](/addons/voice/whisperstt) provides a new offline voice recognition service for openHAB using OpenAI's Whisper model.

But not only were new bindings added, some existing bindings also received massive improvements:

- The [Bosch Smart Home binding](/addons/bindings/boschshc) has added support for new devices: Door/Window Contact II, Universal Switch I+II, Smoke Detector II, Light/Shutter Control II, Dimmer and Smart Water Alarm.
- The [SamsungTV binding](/addons/bindings/samsungtv) has extended support for Frame TV with new channels as well as other improvements.
- The [Shelly binding](/addons/bindings/shelly) has added support for new devices and Range Extender.
- The [HTTP binding](/addons/bindings/http) has received an overhaul with new configuration options, channels and bug fixes.
- The [Netatmo binding](/addons/bindings/netatmo) brings many stability improvements and bug fixes.

## openHABian Enhancements

_Ethan Dye ([@ecdye](https://github.com/ecdye)), openHABian Maintainer_

In openHABian, we've made a couple of under the hood enhancements to provide better support for the users running openHABian:

- Our latest image is now based on Bookworm, the most recent release of Debian/Raspberry Pi OS
- Support for the new Raspberry Pi 5 has been added.
- 64-bit support is now official, [check the docs](/docs/installation/openhabian.html#64-bit) for some caveats on running 64-bit vs 32-bit.

## Documentation Enhancements

As you might have already noticed when taking a look at the 4.2.0 documentation, we have made some changes to the documentation structure.

The first, most obvious change is the new structure of the sidebar:

<div align="center" class="row">
  <img style="max-width: 35%;" src="/uploads/2024-07-07-openhab-4-2-release/docs-sidebar-old.png"/>
  <img style="max-width: 35%;" src="/uploads/2024-07-07-openhab-4-2-release/docs-sidebar-new.png"/>
</div>

As you can see, we now have collapsible sections, which makes the sidebar much more compact and easier to navigate.
Big thanks to Stefan Höhn ([@stefan-hoehn](https://github.com/stefan-hoehn)) for his work on the sidebar!

The second change is the reorganization of the Main UI-related documentation.

The content of the old Settings section has been replaced by a new Main UI section, which now contains detailed documentation about most Main UI pages and follows the structure of Main UI itself.
This documentation is also rendered inside the [Integrated Help Features of Main UI](/blog/2023-12-22-openhab-4-1-release.html#integrated-help-features), which have been introduced in openHAB 4.1.

# Enjoy and Get in Touch!

We hope that you like the new release as much as we do - as always our [community forum](https://community.openhab.org/) is there for questions, comments and discussions.
Do not hesitate to get in touch, join our community, receive help and share your experiences and use cases.
