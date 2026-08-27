---
layout: BlogPost
category: blog
title: openHAB 2.5 Release
author: Kai Kreuzer
date: '2019-12-15T12:26:55+01:00'
previewimage: /uploads/lights.jpg
tags:
  - news
excerpt: >-
  A full year has passed since openHAB 2.4 and a lot has happened meanwhile. A
  new release is overdue and we are happy to announce the new 2.5 release to all
  of you today!
---
A full year has passed since openHAB 2.4 and a lot has happened meanwhile. A new release is overdue and we are happy to announce the new 2.5 release to all of you today!

<!-- more -->

I am sure that many users were awaiting this release since quite a while. In the past, we strived for having at least two releases per year, but we have skipped doing one in summer this year. The reason for this is that some major changes have taken place under the hood, which are not directly visible for users, but that have quite some impact on all developers: We have completely changed the underlying build system. This resulted in much more effort than was initially anticipated and it took many months before maintainers and contributors were back to work on features and not on build- and IDE-related stuff. Nonetheless, we are happy that as a result of this exercise, contributors can now much more easily work with alternative IDEs, such as IntelliJ and VisualStudio Code, what has been a frequent request in the past. Furthermore, the new build system will allow us to significantly speed up build times in future and more easily handle external dependencies.

Another major refactoring that has happened under the hood is the [re-integration of the Eclipse SmartHome code](https://community.openhab.org/t/the-road-ahead-reintegrating-esh/64670) into openHAB, which was completed successfully and left us with a much simpler project and community setup and less inter-project dependencies.

Despite all those internal efforts, I am amazed by the [long list of functional changes](https://github.com/openhab/openhab-distro/releases#newaddons) that the official release notes mention: There are 46 new add-ons included in the distro, which is almost one add-on per week since the last release - another huge step forward in terms of device support, making openHAB a greatly versatile integration platform.

As usual, I won't go into all the details as I would recommend having a look at [the release notes](https://github.com/openhab/openhab-distro/releases/tag/2.5.0) in detail. Instead, let me just mention a couple of additions:

### Ephemeris

The new [ephemeris feature](https://www.openhab.org/docs/configuration/actions.html#ephemeris) allows creating much more fine-grained automation rules: It provides information about the days: Is it a weekday or weekend? Is it a bank holiday? Is it anybody's birthday or maybe time to carry the trash outside? Using the ephemeris information within rules, it is much easier to e.g. adjust times for the automatic shutters, the alarm clock, the appropriate info messages in the morning etc.

This feature comes pre-configured with the official bank holidays for many countries and regions, but it is also fully customizable for other situations and requirements.

### Tesla Binding

With photovoltaic systems becoming more wide-spread and electric vehicles revolutionizing the car industry, the discipline of energy management within smart homes receives an increasing attention. Especially since Tesla's Model 3 has hit the market and has become the [most sold electric vehicle in 2019](https://cleantechnica.com/2019/12/05/tesla-model-3-13-percent-world-ev-sales-2019/), it was important to add support for it in openHAB.

As a result, the [openHAB Tesla binding](https://www.openhab.org/addons/bindings/tesla/#tesla-binding) has been enhanced to support all current models (S, 3, X) and even the upcoming Model Y. The binding provides a [huge list of channels](https://www.openhab.org/addons/bindings/tesla/#channels), which gives access to all aspects of the car and especially to all details around the battery state, available range, charging settings and auto-conditioning.

Besides accessing the vehicle from openHAB, it is obviously also possible to access openHAB from the vehicle as it provides a perfect screen for such purposes.

<p align="center"><img src="/uploads/tesla.jpg"/></p>

### Shelly Binding

Another very popular technology that had a quickly growing community throughout 2019 are the Shelly devices. Those devices are based on ESP chips, providing Wifi connectivity and embracing makers by not relying on a vendor cloud service, but by offering local connectivity through MQTT and CoAP protocols. It is great to see that this strategy proved to be very successful and that the offered product range is thus growing rapidly.

While it was possible to use those devices with the MQTT binding already, the new [openHAB Shelly binding](https://www.openhab.org/addons/bindings/shelly/) makes it much easier for people that are not experienced with MQTT to integrate those devices. The binding supports auto-discovery and internally uses the modern CoAP protocol for communication.

## Apps and Skills

Besides the work on the openHAB distribution, there was a lot of activity in other parts of the overall openHAB solution, which are also worth to mention. I'd like to give the word to the maintainers of the according components:

### openHAB Alexa Skill

_Jeremy Setton, maintainer of the _[_openHAB Alexa skill_](https://www.openhab.org/docs/ecosystem/alexa/)_:_

The new Alexa skill supports Amazon’s latest Smart Home Skill API V3 which provides a much richer set of features to model devices for voice control. While the V2 version of the API allowed basic lighting, thermostat and lock control, the new API can model nearly anything, with native support for AV devices, security systems, scenes, as well as enhanced support for thermostats, locks and lighting/power devices. Most importantly, the skill also supports the flexible building block APIs extending voice control to any devices, from fans to complex appliances, such as washers, to blinds and doors, when associated with the latest semantic extensions feature. Finally, the new API introduces state reporting giving the ability to poll the current state of modeled devices in the Alexa mobile app.

The skill takes advantage of using openHAB metadata instead of tags. This allows a higher level of item customization exposed to Alexa. Existing tags will continue to work with the new skill, so users will not need to migrate their current configuration unless they wish to use the enhanced features that the new version of the skill provides. Additionally, it automatically streamlines the item configuration leveraging some of its properties, such type, state presentation and unit of measurement, along with the server regional settings.

It is [available](https://www.amazon.com/openHAB-Foundation/dp/B01MTY7Z5L) in all the currently supported Alexa skill’s languages and countries:

English (AU), English (CA), English (GB), English (IN), English (US), French (CA), French (FR), German (DE), Hindi (IN), Italian (IT), Japanese (JP), Portuguese (BR), Spanish (ES), Spanish (MX), Spanish (US)

The [latest guide](https://www.openhab.org/docs/ecosystem/alexa/) provides all the necessary information and examples to take advantage of these new features.

### openHAB Google Assistant

_Mehmet Arziman, maintainer of the openHAB Google Assistant:_

The Google Assistant Integration for openHAB, as one of the first included open source projects, received big improvements and refactorings. The overall integration got much more robust, flexible and extensible to be future-proof. The main architecture uses a stable serverless architecture with high security standards. 

The integration works in all the languages that are supported by Google Assistant and it supports the latest Actions of the [Google Smarthome API](https://developers.google.com/assistant/smarthome/overview).

Since being the first open source integration system within Google Assistant, Google added better documentation, examples and more support for device types. The openHAB Google Assistant Integration now supports  almost all possible devices, e.g rollershutters, doors & windows, vacuum cleaners, curtains, (door-)locks and many more. 

### openHAB iOS App

_Tim Müller-Seydlitz, maintainer of the _[_openHAB iOS app_](https://itunes.apple.com/us/app/openhab/id492054521?mt=8)_:_

After a long period of inactivity, the iOS client has received a flurry of new activities bringing the application into the modern world.

While there are numerous changes and updates, by far the largest one is not something that will be immediately visible to end users, but is critically important for future development: the Objective-C based code was completely ported to Swift. The amount of code rework and rewrite for this task was enormous. With our codebase now in Apple’s preferred language, we have come up to par with the development on other platforms. We also laid the foundation for more enhancements of our iOS application and have recruited an active community of contributors.

The most visible change resulting out of this port to Swift was made possible immediately after the release of iOS 13. The iOS app now supports the beautiful Dark Mode.

<p align="center"><img src="/uploads/ioslightdark.jpg"/></p>

Also, video support is enhanced by adding support for mjpeg. The accessibility is improved by handling changes in font size. We implemented haptic feedback and have added a search bar for items in the sitemap. The authentication process was enhanced and is now supporting mTLS client certificates.

### openHAB Android App

In the last few versions the openHAB app for Android got two new features that have been requested for a long time: Widgets and a Tasker plugin. With the latest version the app got also support for the new dark mode of Android 10.

The home screen widgets can be used to set an Item to a specific state or toggle it. You can create widgets from the widget menu in your launcher or via a long click on an Item.

The Tasker action plugin supports setting an Item to a fixed state or to the value of a Tasker variable. It supports both Item commands and updates and reports errors back to Tasker.

<p align="center"><img src="/uploads/android.png"/></p>

## Outlook

With the 2.5 release build, our development master branch has now become 3.0.0. This means that there will most likely be no openHAB 2.6 runtime in future, while there will still be 2.x updates on the add-ons, though.
The focus of the core maintainers will clearly be on openHAB 3 from now on, which will bring bigger changes that have been discussed since a while: The existing UIs will be replaced by a single one, completely implemented from scratch. The "next-generation" rule engine will become the default one, bringing powerful Python-scripting to all users. Many more changes are discussed that will bring you a fully new experience, while offering an upgrade path for all existing users - so stay tuned!

I would like to thank all our maintainers, contributors and users being such a fantastic community. It is awesome that we have reached another big milestone by shipping openHAB 2.5 and it has been a great journey so far - openHAB will celebrate its 10th anniversary next year! Please continue spreading the word and help growing the community.

Enjoy the upcoming festive season, play with the new openHAB release and share your experiences with us, your family and your friends!
