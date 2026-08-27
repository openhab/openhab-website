---
layout: BlogPost
category: blog
title: openHAB 4.1 Release
author: Florian Hotze and others
date: '2023-12-22T18:00:00+02:00'
previewimage: /uploads/2023-12-22-openhab-4-1-release/header.jpg
tags:
  - news
excerpt: >-
  As usual before christmas, we are happy to announce a new release of openHAB, that brings many additions, improvements and fixes!
---
The first minor release of openHAB 4 has arrived! openHAB 4.1 brings several improvements and bugfixes as well as some nice additions!

Half a year has passed since our big [summer release](/blog/2023-07-23-openhab-4-0-release.html).
But don't think for a moment that our community has been resting the rest of the year - far from it!

Today, we are thrilled to announce our traditional winter release.
This new version not only includes a multitude of smaller improvements and bug fixes, but also introduces several exciting new features.

With that being said, we again want to share our highlights and some statistics that show the activity in numbers.

# Activity

As you'd expect from any new openHAB release, we have had a high activity across all our GitHub repositories.
We therefore want to share a few statistics about our three main repositories: Core, add-ons and UIs.

[openHAB Core](https://github.com/openhab/openhab-core) has received 124 pull requests in total, with 32 bug fixes and 46 enhancements resulting in 10,238 lines of code added.

5 new add-ons were introduced, and 437 pull requests, 121 bug fixes and 132 enhancements resulted in 17,746 lines of add-on code added to the [openHAB add-ons repository](https://github.com/openhab/openhab-addons).

Our [openHAB web UIs](https://github.com/openhab/openhab-webui) have also received many contributions: 129 pull requests including 46 bug fixes and 67 enhancements resulted in 5,041 lines of code added, which means our UIs continue to develop at a high pace.

It is worth to mention, that [our other repositories](https://github.com/openhab) have also received numerous contributions (e.g. documentation), but listing them all would probably be too much here.
Big thanks to all our contributors for driving openHAB forward!

Finally, it is time to shout out to our top code contributors per repository (having done the most commits) for this new release:

- Wouter ([@wborn](https://github.com/wborn)) for openHAB core
- Jan ([@J-N-K](https://github.com/J-N-K)) for openHAB core
- Jacob ([@jlaur](https://github.com/jlaur)) for openHAB add-ons
- Leo ([@lsiepel](https://github.com/lsiepel)) for openHAB add-ons
- Florian ([@florian-h05](https://github.com/florian-h05)) for the openHAB Main UI
- Laurent ([@lolodomo](https://github.com/lolodomo)) for the openHAB Basic UI

Many of our top committers are also maintainers, which means besides contributing code, they also review pull requests and participate in discussions on GitHub issues, which helps maintain our high level of quality across bindings, UIs and Core.
At present, we have 35 maintainers across all our repositories.
Many thanks to my colleagues for making openHAB 4.1 a Christmas present to our community!

# Highlights

As you might have already noticed in the activity statistics, openHAB has evolved much, but listing all enhancements would be too much.
Please refer to the [**release notes**](https://github.com/openhab/openhab-distro/releases/tag/4.1.0) to check out what's new and noteworthy (e.g. breaking changes).

In the following sections, our maintainers and contributors are introducing some new features you don't want to miss!

## Add-on Suggestions

While Thing discovery has been supported since openHAB 2.0 (if the binding implements it), users had to manually install the corresponding add-ons.
Particularly for new users, looking up the documentation to identify and install the necessary bindings slowed down the setup of their new openHAB installation.

Six years after the introduction of Thing discovery, we are proud to announce add-on suggestions!

When using the Setup Wizard or the add-on store, openHAB now suggests add-ons based on the devices found in your network and the programs installed on the openHAB server.
This enhances the setup experience, making it more user-friendly, especially for those just getting started with openHAB.

The add-on suggestions feature currently checks mDNS and UPnP traffic and performs a simple IP scan on your network to find out which devices you have at home.
Additionally, the list of running processes of your openHAB server is checked to suggest for example persistence services like InfluxDB.

Many thanks to Mark Herwege ([@mherwege](https://github.com/mherwege)), Andrew Fiddian-Green ([@andrewfg](https://github.com/andrewfg)) and Holger Friedrich ([@holgerfriedrich](https://github.com/holgerfriedrich)) for implementing that awesome new feature!

## Core Runtime Enhancements

### Extending the Ontology with your own Semantic Tags

_Laurent Garnier, openHAB Maintainer_

You can now easily extend the default ontology with your own semantic tags and then use them to build your semantic model.
This can be used for example to add a location or equipment that does not (yet) exist by default.

To define your own semantic tags, create a YAML configuration file containing the description of all your specific semantic tags in the `$OPENHAB_CONF/tags` folder.
You can find a [tutorial on the community forum](https://community.openhab.org/t/oh-4-1-tutorial-to-manage-custom-semantic-tags/148135).

### Voice System Enhancements

_Miguel Álvarez Díez, openHAB Contributor_

Some minor improvements were introduced in the built-in voice system components:

The standard text interpreter now uses the Item's synonyms metadata as alternative names, which helps to avoid name collisions.
It also automatically scans your Item's command description metadata, so that the rule `Set <ItemLabel> to <ItemCommandLabel>` is supported out-of-the-box for all supported languages.

Additionally, the `voiceSystem` metadata namespace was created to allow adding custom rules, for example:

- You can add the rule `go to mode $cmd$ on $name$` to an Item labeled `Vacuum` with command description `MODE_CLEAN=cleaning`:
  That will instruct the interpreter to send the command `MODE_CLEAN` to the Item on the phrase `go to mode cleaning on vacuum`.
- You can also capture free text with a rule like `watch $*$ on $name$`, so that the phrase `watch my favorite show on tv` will send the command `my favorite show` to the Item labeled as `TV`.

Two new configuration parameters were added to the dialog processor start/register command:

- The `dialogGroup` option prevents simultaneous processing of dialogs on the same group, so that several speakers located nearby won't be triggered at the same time.
- The `locationItem` option allows you to forward the location of a speaker/dialog processor to the standard interpreter.
  This makes the interpreter prioritize child Items of the location provided, so that you can use "Light" as Item label for two Items in different two different rooms with a speaker each, and the phrase `Turn on the light` will target the light Item of the correct room.

### Time Series Support for Forecasts and Historical Values

_Jan N. Klug & Kai Kreuzer, openHAB Maintainers_

Imagine your electricity provider has dynamic pricing, e.g. a different price for every hour (like Tibber does):
You could plan to charge your electric car or start the dishwasher when prices are low or inhibit the start of your washing machine when the price is high.

In the past it was very difficult to handle that, but with our new release the situation greatly improves:
Until now, openHAB was only able to keep track of the current state of Items and, as persistence could handle only values in the past, historical states of Items.
So how to handle future values?

We have solved that difficulty with the introduction of `TimeSeries`:
Bindings can now send a time series (a set of timestamp/value pairs) to a channel, just like they send usual states and openHAB core will take care of handling the time series.
This way they are able to provide future values for Items, be it weather forecasts, energy prices or whatever.

The first bindings to support this new feature are the [OpenWeatherMap](/addons/bindings/openweathermap/#persisting-time-series) and [Energi Data Service](/addons/bindings/energidataservice/) bindings.

If you have persistence configured for an Item and the persistence service supports time series (most do: InfluxDB and JDBC will work fine, but RRD4J not), then sending a time series can be used to fill gaps in the past ("historic values", e.g. due to network issues) or - probably more important - store future values ("forecasts") for this Item.
A new persistence strategy `forecast` has been introduced, which does the real magic:
The Item's state will be updated to a value with a timestamp send in a time series just at the time the timestamp becomes current.
This way our Item will always reflect e.g. the current price, even if this forecast information was made available yesterday.

As a result, it is not only possible to generate charts for these future values, but they can also be easily used within rules through the persistence extensions.
This makes it much easier for users to implement complex optimization logic that requires forecast data, e.g. for heating control or energy management.

With the introduction of time series, we have made the first step for more advanced energy management solutions within openHAB, and there is also ongoing work on the persistence extensions to improve forecast handling in rules.
Stay tuned!

### Units of Measurement: Currencies have arrived

_Jan N. Klug, openHAB Maintainer_

openHAB had good support for handling units in the past and that made a big step forward in ease-of-use with openHAB 4.0,
but what was still missing (especially for energy management) was support for currencies, so we have now added two new dimensions: `Currency` and `EnergyPrice`.

Compared to "usual" units, currencies are very different:
There are a lot more of them (each country has a different one) and even worse: Their "conversion factor" is not fixed.

Think of length measurement: Basically there is the metric and the imperial system.
The conversion from `mm` to `inch` is `25.4 mm = 1 inch`, which has been the same ten years ago and will also be the same in 2050.
In contrast to that, the factor (exchange rate) for Euro to US-Dollar changes on a very short timescale.

And it's even more complicated than that: A lot of countries use similar symbols (e.g. `$`) for their currency, but they mean different things: A Canadian dollar is not the same as a US dollar.
Luckily the ISO comes to our help: [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) defines three letter "currency codes", which are unique for major currencies.

To support currencies, openHAB adds a new type of service: the `CurrencyProvider`.
A `CurrencyProvider` can support one or more currencies (with at least the "currency code" as identifier) and brings the information how to convert between them.

Out of the box openHAB comes with two very basic `CurrencyProviders`, both support only one currency, but you can still use them for calculations.
The "locale base currency provider" selects the currency based on the configured locale, so in Germany the currency will be "EUR", in Denmark it will be "DKK".
The "fixed currency provider" allows you to define your own currency, you just have to set a three-letter code (see [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217)) that identifies it.

There are plans to enhance that with support for multiple currencies and automatic update of exchange rates.

You can find a [tutorial on the community forum](https://community.openhab.org/t/using-the-new-currency-units-of-measurement-in-4-1/152338).

## Main UI Enhancements

_Florian Hotze, openHAB Maintainer_

### Redesigned Settings Menu

Let's take a look at the settings menu from openHAB 4.0.x:

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-12-22-openhab-4-1-release/mainui-settings-4-0.png"/></p>

Even though your were able to change most settings from it, it had a few drawbacks:

- Displaying all settings in the "System Settings" section, including those more advanced, cluttered the view (especially on smaller screens).
- Whilst access to the add-on store from the settings menu worked, it wasn't very intuitive to have it in the settings menu.
- The page did not use the additional space provided by large/wide screens, but at the same time was relatively high, so you had to scroll to see all entries.
- Add-on settings had to be accessed through the add-on store.

So we decided that openHAB 4.1 is a good chance to redesign the settings menu and move the add-on store to its own entry in the sidebar:

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-12-22-openhab-4-1-release/mainui-settings-4-1.png"/></p>

As you can see, the new settings menu fixes those drawbacks:

- The "System Settings" section now hides advanced settings (depending on screen size).
- The add-on store section has been moved to the sidebar:
  <p align="center"><img style="max-width: 30%;" src="/uploads/2023-12-22-openhab-4-1-release/mainui-add-on-store.png"/></p>
- The settings page now uses three columns on large screens and isn't that high anymore.
- Add-on settings were (re-)introduced, and now it is also possible to set their log level right from the settings menu - just expand the section to see all installed add-ons.

### Integrated Help Features

_Justin Georgi, openHAB Contributor_

In addition to the well-known useful tools for developers, the developer sidebar now provides a help section directly integrated to the UI.
This new help panel will be useful for users just getting started with openHAB as well as advanced users looking for quick access to some of the most common detailed documentation.

The help section provides four different help features:

- A context aware help pane shows basic help and guidance for many of the individual setting and administration pages of Main UI.
- A binding help pane lists direct links to the documentation pages for each official binding installed.
- A FAQ pane gives quick answers and How Tos for many common questions about Main UI and openHAB in general.
- A Quick Start tutorial takes a new user step by step from a freshly installed openHAB server all the way to display an interactive widget on the Main UI overview page.

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-12-22-openhab-4-1-release/mainui-help-features.png"/></p>

To use the new help feature, make sure you are logged in as administrator, then click on the question mark in the upper right corner.
Please note that it is only shown if your screen is wide enough (>= 1280 px).

### UI Command Item

I guess since the introduction of Main UI with openHAB 3.0, which was released exactly three years ago (let us ignore that one day difference), many users have moved over their home automation dashboards from HABPanel to Main UI.
But the whole time, Main UI was lacking a feature, that HABPanel has: The ability to control the UI using an Item.

In HABPanel, it is possible to switch the dashboard by commanding an Item - what if you could do the same (and much more) in Main UI?
openHAB 4.1 finally adds that feature!

The UI Command Item basically is a `String` Item to which these supported commands are sent:

- `navigate`: Navigate to a given page path, e.g. `navigate:/locations` to navigate to the locations tab.
- `popup`, `popover` & `sheet`: Open a widget, an `oh-` component or a page in the given modal, e.g. `popup:oh-clock-card`.
- `notification`: Display a notification inside the UI, e.g. `notification:Merry Christmas and happy holidays!:openHAB 4.1`
- `close`: Close all popups, popovers and sheets.
- `back` & `reload`: Navigate back or reload the current page.

The UI Command Item has to be configured for each client inside Main UI's settings: "Help & About" > "Listen for UI commands to".
Unfortunately, we don`t have documentation for that at the moment, but for those wanting to play around with that new feature, you can have a look at the [pull request](https://github.com/openhab/openhab-webui/pull/2055) for some additional examples.

Many thanks to Dan Cunningham ([@digitaldan](https://github.com/digitaldan)) for implementing that!

### Blockly Enhancements

_Stefan Höhn, Blockly Maintainer_

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-12-22-openhab-4-1-release/blockly-4-1.png"/></p>

Blockly has been further extended by some new blocks and enhancements that were requested by our community:

- Support String/Number/Quantity on eventcontext state/command
- Add Quantity support to math blocks
- New parse number block
- Allow "item xxx" to be used directly instead of "get xxx of item"
- New block to get hue, saturation and brightness from Color Item
- Add "event available" to context info block
- Add support for getting persistence previous state as numeric starte

## Sitemap and Basic UI Enhancements

_Laurent Garnier, openHAB Maintainer_

### New Sitemap element: `Buttongrid`

A `Buttongrid` represents a grid of buttons as typical for remote controls:
It allows to arrange a number of buttons, either labelled with a string or an icon, in a custom format.
When a button is pressed, the associated command is sent to the linked Item.

Here is the result in Basic UI, using the following definition:

```java
Buttongrid label="Remote Control" staticIcon=screen item=RemoteControl buttons=[1:1:POWER="Power"=switch-off , 1:2:MENU="Menu" , 1:3:EXIT="Exit" , 2:2:UP="Up"=f7:arrowtriangle_up , 4:2:DOWN="Down"=f7:arrowtriangle_down , 3:1:LEFT="Left"=f7:arrowtriangle_left , 3:3:RIGHT="Right"=f7:arrowtriangle_right , 3:2:OK="Ok" , 2:4:VOL_PLUS="Volume +" , 4:4:VOL_MINUS="Volume -" , 3:4:MUTE="Mute"=soundvolume_mute]
```

<p align="center"><img style="max-width: 70%;" src="/uploads/2023-12-22-openhab-4-1-release/basicui-buttongrid.png"/></p>

Please note that the support for this new element is currently limited to Basic UI. However, efforts are underway to extend its support to the Android app.

### Other Sitemap Enhancements

- When using [mappings](/docs/ui/sitemaps.html#mappings) with the `Switch` element, you can now also provide an optional icon for each button.
  UIs that support this new feature (Basic UI and Android app) will then display the icon inside the button rather than the text.
- There is also a new and more powerful way to define a [dynamic icon](/docs/ui/sitemaps.html#icons) based on the states of different Items and allowing you to attach any type of icon regardless of its source (not restricted to icons provided by openHAB).
  As with visibility or label color, you can define a list of conditions, each referencing a (potentially different) icon.
- Combining several conditions for visibility or color of label, value and icon is now possible by using the `AND` operator.
  Of course, it is possible to reference a different Item in each singular condition.
- The syntax of the `period` parameter of `Chart` elements has been extended.
  Valid values are now `h, 2h, 3h, ..., D, 2D, 3D, ..., W, 2W, 3W, ..., M, 2M, 3M, ..., Y, 2Y, ...` and any valid duration following the ISO8601 duration notation such as `P1Y6M` for the last year and a half or `PT1H30M` for the last hour and a half.
- The `staticIcon` parameter can now be used in place of the `icon` parameter when you want to indicate to UIs that there is no need to refresh the icon when the state of the Item is updated.
  This can reduce network traffic when you have very frequent updates to an Item.

### Basic UI Enhancements

- A header row with a label and icon is now displayed for `Chart`, `Image`, `Video`, `Mapview` and `Webview` elements.
  To be displayed, the `label` parameter must be explicitly defined.
  Additionally, for `Chart` and `Image` elements, the display of this header row can be toggled by clicking on the image.
- The image of a `Chart` or `Image` element is now never scaled by default but there is now a button in the header row to toggle between the scaled image at the screen width and the image to its original size.
  For `Chart` elements, there are more buttons in the header row such as one to toggle between showing or hiding the legend or one to select the chart duration from a few predefined durations.
- Framework7 icons are now supported.
- A new parameter now allows you to select the number of columns that will be used to display sitemap elements.
  On a large screen (desktop), you have the choice between 1, 2 or 3 columns.
  On a tablet, you have the choice between 1 or 2 columns.
- The page listing the sitemap to select now displays the sitemap label.
- Several enhancements and fixes for the dark theme.

## Add-on Enhancements

openHAB 4.1 brings 5 new add-ons, adding support for new devices:

- The [SolaX binding](/addons/bindings/solax) enables interaction with the Wi-Fi module of SolaX solar inverters.
- The [Govee binding](/addons/bindings/govee) integrates [Govee lights](https://eu.govee.com/) using the local API - no cloud needed!
- The [TasmotaPlug binding](/addons/bindings/tasmotaplug) connects Tasmota flashed smart plugs to openHAB.
- The [Grundfos Alpha binding](/addons/bindings/bluetooth.grundfosalpha) adds support for reading data from Grundfos Alpha heat pumps equipped with a Grundfos Alpha Reader.
- The [PPC SMGW binding](/addons/bindings/smgw) reads data from your smart meter gateway.

But not only were new bindings added, some existing bindings also received massive improvements:

- The [ChatGPT binding](/addons/bindings/chatgpt) adds support for [LocalAI](https://localai.io/) and other compatible services, removing the need to share data with the cloud.
- The [Philips Hue binding](/addons/bindings/hue) improves support for API v2, now also offering smart scenes, timed effects and support for new home security products.
- The [KNX binding](/addons/bindings/knx) introduces a new modifier to set the mainGA write-only, which is allows ignoring bus messages to the mainGA when having a dedicated status GA.
- The [OpenWeatherMap binding](/addons/bindings/openweathermap) implements time series support for the OneCall API forecast, which allows disabling the massive amount of individual channels used for each forecast value at each point in time.

# Enjoy and Get in Touch!

We hope that you like the new release as much as we do - as always our [community forum](https://community.openhab.org/) is there for questions, comments and discussions.
Do not hesitate to get in touch, join our community, receive help and share your experiences and use cases.
