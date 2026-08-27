---
layout: BlogPost
category: blog
title: openHAB 2.3 Release
author: Kai Kreuzer
date: '2018-05-28T13:24:00+02:00'
excerpt: "Time flies! The last openHAB release is already more than 5 months old and much has happened since then. It is therefore clearly time to pack and ship all the nice new updates as a stable release: Here comes openHAB 2.3!"
previewimage: /uploads/homepage.jpg
tags:
  - news
  - release
---
Time flies! The last openHAB release is already more than 5 months old and much has happened since then. It is therefore clearly time to pack and ship all the nice new updates as a stable release: Here comes [openHAB 2.3](/download/)!

<!-- more -->

All details about the included features and fixes are listed in the [official Release Notes](https://github.com/openhab/openhab-distro/releases/tag/2.3.0), but please allow me to point you to some of my personal highlights:

## Localisation

A lot of effort went into translation work during the past months: Not only the openHAB dashboard, but also HABPanel and the Android app have been translated into many languages by community members all over the world. We are using the [Crowdin service](https://crowdin.com/projects?q=openhab) for this, which makes it really easy for people to contribute - it is a perfect start for actively participating in the community!

<!--{:.center}-->
<img class="img-responsive" src="/uploads/translations.png" alt="">
<small>Languages covered by HABPanel</small>

## Units of Measurement

Another great feature that makes it much easier to use openHAB all over the world is the new support for units on numbers. This make it now possible to e.g. use imperial units even if your sensors deliver values in the metric system. You can thus have all your temperatures shown as `°F`, completely independently from the hardware you are using - the conversion is automatically done by the framework. This not only works for simple conversions like `°C` to `°F`, but also for `hPa` to `inHg` or similar things. Likewise, you can even decide to have different representations within your own measurement system. So while your sensor might deliver data in `m/s`, you can simply define that this is shown as `km/h` in your user interface.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/uom.png" alt="">

The real power of the unit support can be seen when being used within rules: Calculations can now be done unit-safe, thus [unit disasters](http://mentalfloss.com/article/25845/quick-6-six-unit-conversion-disasters) can be avoided. Even if you add `23|°F + 82|°F + 302|K` or `5|m + 30|cm + 0.01|mi` within a rule (note that the `|` is used as a delimiter between the value and its unit in rules), the result is always correctly calculated. You can find more technical background information about this feature in the [Eclipse SmartHome blog](https://www.eclipse.org/smarthome/blog/2018/02/22/units-of-measurement.html).

## New Integrations

We have a new record for the number of new add-ons for a release: openHAB 2.3 brings 25 new add-ons to the existing pool! This roughly makes one new add-on per week - despite this success, there are still plenty further add-ons in the review queue, so future releases are not likely to slow down much.

Worth to mention are the integrations with two quite widely used systems (at least in Germany): [innogy](/addons/bindings/innogysmarthome/) with a broad portfolio and [tado°](/addons/bindings/tado/) with climate and heating devices. Unfortunately, both of them do not offer any local integration, so that offline situations can not be covered.

A more geeky device that is great for notifications is [LaMetric Time](/addons/bindings/lametrictime/): With its huge dot matrix display, it is perfect as a feedback channel to the users.

<!--{:.center}-->
<img class="img-responsive" src="/uploads/lametric.jpg" alt="">

Another cool addition is the [Amazon Echo Control binding](/addons/bindings/amazonechocontrol/), which gives full control over Amazon Echo devices, so that you can control the media playback, use it as a text-to-speech service or trigger reports like the daily briefing or the weather forecast.

Last but not least: The very first binding that was written in 2010 for openHAB has finally been migrated to a [fully 2.x compatible implementation: KNX](/addons/bindings/knx/)! This new implementation not only makes it possible to also configure the KNX integration through the Paper UI, it furthermore supports reading information from physical KNX addresses, such as manufacturer and firmware ids and it can also ping those addresses in order to determine whether the devices are still available on the bus.

## Ecosystem News

Besides the distribution of the runtime, you should also be aware of some news from other components within the openHAB ecosystem:

### Google Assistant Integration

openHAB has an officially certified [openHAB Google Assistant Smart Home Action](/docs/ecosystem/google-assistant/). The openHAB Action is one of the first open source smart home integrations in the Google Assistant ecosystem and allows users to connect their openHAB instances through the [myopenHAB service](https://www.myopenhab.org) to Google Assistant and easily manage and control their homes by voice. There is a step by step [guide](https://github.com/openhab/openhab-google-assistant/blob/master/USAGE.md) on how to use the openHAB Google Assistant Smart Home Action. The Action supports lights, plugs, switches and thermostats. It comes with multiple supported languages like English, German and French.

Besides [Alexa](/docs/ecosystem/alexa/) and [MyCroft](/docs/ecosystem/mycroft/), this is the third voice assistant that can be used with openHAB.

### openHAB Cloud runs from Docker to Kubernetes

[openHAB Cloud](https://github.com/openhab/openhab-cloud/blob/master/README.md#openhab-cloud) now supports a cloud native architecture, powered by the open source [Kubernetes](https://kubernetes.io/) system to enable more scalable openHAB Cloud platform setups and deployments. openHAB Cloud comes with easy to use [deployment scripts](https://github.com/openhab/openhab-cloud/blob/master/deployment/kubernetes/kubernetes-deploy.sh) for Kubernetes and OpenShift. The Kubernetes feature relies on containers, distributed management and orchestration, and openHAB Cloud will soon completely shift into the use of microservices designed for cloud environments. More detailed information on how to deploy openHAB Cloud using Docker, Kubernetes or OpenShift can be found [here](https://github.com/openhab/openhab-cloud/tree/master/deployment).

<img class="img-responsive" src="/uploads/k8sopenshift.png" alt="">

### openHAB Android App

The [openHAB Android app](https://play.google.com/store/apps/details?id=org.openhab.habdroid) is very actively maintained and there were many bigger and smaller improvements over the last months, like the improved voice integration, the support for locations and maps, refresh on swipe, etc. Besides the version in the Play Store, there is also a Google-free, pure open-source version of the [app available on F-Droid](https://f-droid.org/packages/org.openhab.habdroid/).

### Project Website

We have launched our completely re-designed website this weekend - besides being more modern and faster, it now seamlessly includes this blog, has a great [showcase section](/about/showcase.html) and an excellent [search for supported devices](/addons/) (including a [complete list of all Z-Wave devices](/addons/bindings/zwave/doc/things.html)).

For those who are interested in "offline information", don't miss to check out the new list of [upcoming events](/about/events.html)!

### Community

As always, I would very much like to thank all our community members that contributed to all those efforts - such a progress is only possible through the immense dedication of many different people and it is a great honor to serve this community as a project lead - keep up the awesome work!
