---
layout: BlogPost
category: blog
title: openHAB 2.0 beta3 Release
date: '2016-05-23T00:00:00.001+02:00'
author: Kai Kreuzer
tags:
- openhab
- eclipse
- pine64
modified_time: '2016-05-23T00:00:00.001+02:00'
excerpt_separator: <!-- more -->
previewimage : /uploads/2016-05_building.jpg
---

Some time has passed since the openHAB 2.0 beta2 release and a lot development efforts were done - so it was clearly time to [release openHAB 2.0 beta3](https://github.com/openhab/openhab-distro/releases/tag/2.0.0.b3). I see that many openHAB contributors and users are moving over from 1.x by looking at the activity in our forum and there has been very positive feedback regarding the stability.

<!-- more -->

This is also clearly indicated by the heavily increased number of [1.x add-ons that were successfully tested](http://docs.openhab.org/features/bindings.html#compatible-1x-add-ons) and thus included in the openHAB 2 distribution - we have reached 80 add-ons now, complementing about 40 add-ons that were built for openHAB 2 right from the start. We are therefore getting much closer to having the openHAB 2 runtime as a full replacement for the openHAB 1 runtime for all existing users. When using textual configuration, it is fairly similar to setup and use.

Two missing parts are being heavily worked on:

- A [new openHAB 2 Documentation website](http://docs.openhab.org/) has been created with some initial content, which will grow heavily in the coming weeks to make it easier for newcomers to get into openHAB 2.
- The [Debian packages](https://github.com/openhab/openhab-distro/issues/66) are now produced by the build and it will soon be possible to install openHAB 2 through a simple "apt-get" on Linux.

Besides offering the comfort that people are used to in openHAB 1.x, there was of course also a lot of activity on the core framework (i.e. Eclipse SmartHome). This has specifically gained momentum since the end of last year, which can be nicely seen in the Github statistics.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/2016-05_esh-stats.png" alt="">
<small>Commit activity on Eclipse SmartHome</small>

This activity resulted in [337 merged pull requests](https://github.com/eclipse/smarthome/issues?q=milestone%3A0.8.0.b5) since the beta2 in January, which makes Eclipse SmartHome one of the most active projects in the [Eclipse IoT](http://iot.eclipse.org/) space.

Besides many small improvements and evolution of the binding APIs, a lot of work went into the Paper UI through which it is now possible to configure bindings and services as an alternative to the textual configuration files.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/2016-05_paperui.png" alt="">
<small>System configuration through the Paper UI</small>

Other features are a fully re-implemented [LIFX binding](http://docs.openhab.org/features/bindings/lifx/readme.html), which now requires less system resources, an update Philips hue binding, which now also supports alarm and color cycle options as well as a greatly enhanced [Sonos binding](http://docs.openhab.org/features/bindings/sonos/readme.html), which can now handle speaker groups, play notifications and many more things.

Two bindings that have by far the largest user base have been ported to openHAB 2 and now fully support discovery of devices, which is very useful in both cases, which are Z-Wave ad Homematic. Z-Wave supports a huge list of devices already and Chris is doing a phantastic job to maintain them in a dedicated [device database](http://www.cd-jackson.com/index.php/zwave/zwave-device-database/zwave-device-list). For Homematic, this is not even necessary since the binding directly queries the Homematic CCU2 for the device meta-data and builds the openHAB-internal representation dynamically at runtime. 

Last but not least, I would like to mention the [digitalSTROM binding](http://docs.openhab.org/features/bindings/digitalstrom/readme.html) - this has been developed by the [FH Köln](http://www.software-quality.fh-koeln.de/iemwiki/index.php/Hauptseite) and is by far the largest contribution in terms of lines of code and complexity of the integrated system.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/2016-05_ds.jpg" alt="">
<small>digitalSTROM actuators</small>

My favorite new additions are no bindings though - they are the native [integration with HomeKit](http://docs.openhab.org/features/io/homekit/readme.html) as well as with [Amazon Echo by emulating a hue bridge](http://docs.openhab.org/features/io/hueemulation/readme.html). In the past people were using additional software like the ha-bridge or the openhab-homekit-bridge. Now this is fully integrated into openHAB and you can easily use Siri or Alexa for accessing anything that is connected to your openHAB installation.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/2016-05_echo.jpg" alt="">
<small>Amazon Echo now works with openHAB</small>

The last good news about the beta3 release is that it is included in the SD card image that I have prepared for the [PINE64](http://www.pine64.com/). The PINE64 IoT package will be sent out to the backers starting later this week and it will directly ship with openHAB 2.0 pre-installed. For all other PINE64 users, who just ordered the board (most have already received it), the image will also be made available for download, so that you can flash yourself an SD card - it has never been easier to start with openHAB!
