---
layout: BlogPost
category: blog
title: openHAB 2.4 Release
author: Kai Kreuzer
date: '2018-12-17T00:57:45+01:00'
previewimage: /uploads/2018-12_xmas.jpg
tags:
  - news
excerpt: >-
  As for the past few years, the openHAB maintainers have decided to do a new
  release just in time for the holiday season, which is the busiest time of the
  year in our community. So what could be more welcome than a brand new stable
  release?
---
As for the past few years, the openHAB maintainers have decided to do a new release just in time for the holiday season, which is the busiest time of the year in our community. So what could be more welcome than a brand new stable release?

<!-- more -->

The community has been again pretty active in the past six months since the last release. The clearest sign of this is the huge number of 34 new add-ons, but also the core runtime as well as existing add-ons have further evolved. All details can be found in the [openHAB 2.4 Release Notes](https://github.com/openhab/openhab-distro/wiki/openHAB-2.4-Release-Notes), but I'd like to mention a few specifically:

## Profiles

[Profiles](https://www.openhab.org/docs/configuration/items.html#profiles) are a newly introduced, very powerful feature, which helps reducing the complexity of configurations for the Smart Home. In many homes there are some recurring patterns of how devices interact which each other: Buttons or rockers are for example often used to turn some other device on or off. Another common use case is that multiple devices (e.g. multiple bulbs within the same lamp) should always act together as if they were a single device. While it was already possible to fully cover these use cases with rules so far, it often resulted in numerous rules that do similar logic, but for different devices. Especially in large-scale setups, this could make it hard to keep the overview and maintain these rules. 

A Profile describes the behavior of a link between a Channel and its associated Item (i.e. the raw function of a device and its logical representation within openHAB) and can thus completely replace simple rules. Through selecting an appropriate Profile, a wall switch can easily be assigned to toggle a light or to pause/resume a speaker. Likewise it is possible to offset a sensor value by a certain amount or to do any kind of more complex transformation on incoming values - all without writing a rule.

<p align="center"><img src="/uploads/2018-12_profiles.png"/></p>

The Paper UI lists all applicable profiles when linking an Item to a Channel and only more advanced profiles require some additional configuration, which can all be done through the UI. More details and examples on how to use Profiles can be found in [the documentation](https://www.openhab.org/docs/configuration/items.html#profiles).

## Voice

There are two new options available for text-to-speech: The first is the [Google Cloud TTS engine](https://www.openhab.org/addons/voice/googletts/), the second is the [Pico TTS service](https://www.openhab.org/addons/voice/picotts/), which produces high-quality results on Linux systems, even on embedded devices such as the Raspberry Pi.

#### HABot

HABot is related to voice, but it actually brings the best of two worlds together: It combines voice interaction with the benefits of graphical user interfaces and thus defines a completely new UI approach for openHAB - a chat bot!
You can ask HABot questions about your home and it is able to present the desired information on the screen; this can be suitable widgets to control some devices, it can be a chart with historic values or an image of a webcam - anything you wish. It is furthermore highly customisable, i.e. it is possible to fine-tune its feedback and the next time, the customised screen will be shown right away. It is also context sensitive, so depending on the situation - e.g. whether you are at home or not or whether it is night or day - it can present different responses.

Under the hood HABot uses natural language processing (NLP) and machine learning (using Apache OpenNLP) and it can be easily extended by capabilities, the so-called "intents". It is important to note that HABot only got started, so while already useful, its feature scope is still limited. Nonetheless, it guides the way towards a modern interaction scheme with the smart home and we will see it further evolving over the next releases.

<p align="center"><img src="/uploads/2018-12_habot.png"/></p>

To learn more about HABot, check out [Yannick Schaus presentation](https://youtu.be/y_3U4zcD5i4?list=PLEGbpQEn6rvyikXIhZXmuztwgUz7V8Ufs) or follow the [HABot walkthrough](https://community.openhab.org/tags/c/apps-services/habot/walkthrough) in our forum. 

## Device Integrations

##### Smart Meter

On the bindings side, a great step forward for everyone who wants to realise energy management use cases with openHAB is the fact that a big range of smart meters are now supported: The [SmartMeter binding](https://www.openhab.org/addons/bindings/smartmeter) supports the IEC 62056-21 protocol, which is an international standard for retrieving data from meters. Additionally, it also supports the Smart Meter Language (SML), which is used by some smart meters to actively push structured datasets. The other relevant binding is the [DSMR binding](https://www.openhab.org/addons/bindings/dsmr), which knows how to deal with the full range of smart meters in the Netherlands.

##### GPS Tracker / OwnTracks

One of my favorite additions is the [GPSTracker binding](https://www.openhab.org/addons/bindings/gpstracker), which nicely integrates [OwnTracks](https://owntracks.org/booklet/) with openHAB. In the past, you had to run an exposed MQTT broker to which OwnTracks published its data, which wasn't easy to do for users and which also meant a security risk, if not done properly. The new integration now supports the private HTTPS mode of OwnTracks and can be used in conjunction with [myopenHAB.org](https://www.myopenhab.org/) to securely pass the data to the local openHAB instance. It has never been so easy to use geofences for your automation logic!

<p align="center"><img src="/uploads/2018-12_owntracks.jpg"/></p>

##### EnOcean

All users of EnOcean devices will be delighted to hear that there is finally support for actuators and not just sensors available. Furthermore, the [new EnOcean binding](https://www.openhab.org/addons/bindings/enocean/) brings automatic discovery of devices as well as secure pairing - EnOcean is now a first-class citizen in openHAB!

##### MQTT

Last but not least, the binding that is one of the most commonly used one has finally been ported to openHAB 2: the [MQTT binding](https://www.openhab.org/addons/bindings/mqtt)! "MQTT" regularly being the top search keyword on the openHAB website is a clear indication that MQTT has managed to become the de-facto standard protocol for any DIY hardware integration. It is the first choice for many tinkerers that e.g. use Arduinos or ESP8266 as hardware.
The new MQTT binding not only makes it much easier to setup an integration as this can now optionally be done fully through a graphical user interface (Paper UI), but it also knows about the [Homie convention](https://github.com/homieiot/convention) and even detects Home Assistant installations in the local network and brings their devices into the openHAB Inbox. You can find out more about all the new MQTT features in a [dedicated blog post](https://www.openhab.org/blog/2018-12-16-mqtt-arrives-in-the-modern-openhab-2-x-architecture.html).

## Community

It is awesome to see how the community keeps growing and how many new people are getting actively involved in the project. I feel that I am less and less a bottleneck for openHAB and I plan to further push into this direction, i.e. share more responsibilities and have more people steering the project. One part of this job will be to simplify the overall project setup and automate even more. With [monthly milestone builds](https://community.openhab.org/t/openhab-2-4-milestone-builds/50359) since summer, we are on a good path already.

I can only re-iterate that all this is only possible by the many volunteers in the community - and anybody who wants to help on this joint effort is very welcome to become a part of it! So don't be shy and always remember that open source is not about being free (as in beer), but about sharing with others. Merry Christmas to all of you!

<p align="center"><img src="/uploads/2018-12_xmas.jpg"/></p>
