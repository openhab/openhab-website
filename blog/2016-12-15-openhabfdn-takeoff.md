---
layout: BlogPost
category: blog
title: The openHAB Foundation is Ready for Takeoff!
date: '2016-12-15T12:00:00.001+02:00'
author: Kai Kreuzer
tags:
- openhab
modified_time: '2016-12-15T12:00:00.001+02:00'
excerpt_separator: <!-- more -->
previewimage : /uploads/2016-12_takeoff.jpg
---

Since the inception of the idea to start a nonprofit organization around openHAB, some time has passed and we have been working intensively on making it happen!

Today, I am very proud to be able to announce that the openHAB Foundation e.V. is up and running and has successfully taken over all sorts of supportive operation for the community.

<!-- more -->

Here's a brief overview of what the foundation does for you:

## From Source to Binary

Ever had to build applications from source code yourself? We are making sure that binaries are built for the latest sources as well as for releases and that they are easily accessible for everyone.
For this, we maintain and monitor the build infrastructure. And to give you an idea of how openHAB looks and feels like before you even get started, we are hosting a public demo instance.

 <div class="row">
            <div class="col-md-4 img-portfolio">
                <a href="https://openhab.ci.cloudbees.com/job/openHAB-Distribution/">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_jenkins.png" alt="">
                </a>
                <h3>
                    <a href="https://openhab.ci.cloudbees.com/job/openHAB-Distribution/">Build Server</a>
                </h3>
                <p>The builds are executed on a Jenkins instance on Cloudbees. We have monitoring setup to be immediately informed about broken builds through a slack channel.</p>
            </div>
            <div class="col-md-4 img-portfolio">
                <a href="https://bintray.com/openhab">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_bintray.png" alt="">
                </a>
                <h3>
                    <a href="https://bintray.com/openhab">Release Downloads</a>
                </h3>
                <p>We use the services of Bintray to host our binaries for download. This not only comprises the final distribution zips, but also the Debian packages and dependencies required during the build.</p>
            </div>
            <div class="col-md-4 img-portfolio">
                <a href="http://demo.openhab.org:8080/start/index">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_demo.png" alt="">
                </a>
                <h3>
                    <a href="http://demo.openhab.org:8080/start/index">Demo Server</a>
                </h3>
                <p>This is a real openHAB instance with the demo package deployed on it. Great for testing the user interfaces and the REST API online, but obviously no real devices are connected to it.</p>
            </div>
</div>
 
We are also publishing the openHAB apps in the official stores. So far, we have apps for Android, iOS and Pebble, which will soon be complimented by apps in the Windows Store and for Ubuntu Core.

 <div class="row">
            <div class="col-md-4 img-portfolio">
                <a href="https://play.google.com/store/apps/details?id=org.openhab.habdroid">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_playstore.jpg" alt="">
                </a>
                <h3>
                    <a href="https://play.google.com/store/apps/details?id=org.openhab.habdroid">Google Play Store</a>
                </h3>
                <p>The Android app (aka "HABDroid) for openHAB</p>
            </div>
            <div class="col-md-4 img-portfolio">
                <a href="https://itunes.apple.com/us/app/openhab/id492054521?mt=8">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_appstore.jpg" alt="">
                </a>
                <h3>
                    <a href="https://itunes.apple.com/us/app/openhab/id492054521?mt=8">iOS App Store</a>
                </h3>
                <p>The iOS app for openHAB</p>
            </div>
            <div class="col-md-4 img-portfolio">
                <a href="https://apps.getpebble.com/en_US/application/5542604d45bf334314000098">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_pebblestore.jpg" alt="">
                </a>
                <h3>
                    <a href="https://apps.getpebble.com/en_US/application/5542604d45bf334314000098">Pebble App Store</a>
                </h3>
                <p>The Pebble app for openHAB</p>
            </div>
</div>

## Discussion Forum and myopenHAB 

Probably the most valuable service, which many users regularly use is [our discussion forum](https://community.openhab.org/). We are not only hosting the software and making sure it runs smoothly, but we also moderate discussions, answer questions and offer help.

All of this has been set up over the past months since the openHAB Foundation was established.

But the biggest news of today is that we have now also setup a hosted version of the openHAB Cloud!

You have never heard of the openHAB Cloud before? Well, you might have heard of my.openHAB, which is operated by the (now closing) openHAB UG. The contributors have recently [open-sourced its code base](https://github.com/openhab/openhab-cloud#openhab-cloud) and called it the "openHAB Cloud". This now makes it possible to have a private cloud set up, which can be used for integrations that require cloud connections through OAuth2 like e.g. IFTTT, Alexa skills etc. Many people were asking for this and I look forward to community contributions for its further evolution!

Although it is all nicely documented, setting up an openHAB Cloud instance is not what a regular user will be able or willing to do. To show the possibilities and have it easily available to everybody, the openHAB Foundation hosts a public instance where everybody is free to register - it is callen myopenHAB (note the missing dot) and is available at [www.myopenhab.org](http://www.myopenhab.org). This instance comes with support for IFTTT integration as well as with the new openHAB Alexa Smart Home skill (which is also [available as open-source](https://github.com/openhab/openhab-alexa#amazon-alexa-smart-home-skill-for-openhab-2)) and although it is meant as a show case and we cannot offer any SLAs, we are confident to provide a better availability than what the "old" my.openHAB had to offer. We therefore strongly recommend all existing users to move over to the new [foundation-hosted myopenHAB](http://www.myopenhab.org)!

 <div class="row">
            <div class="col-md-6 img-portfolio">
                <a href="https://community.openhab.org/">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_forum.png" alt="">
                </a>
                <h3>
                    <a href="https://community.openhab.org/">Discussion Forum</a>
                </h3>
                <p>The forum is the central place to get support, help others, get in touch with the community, share ideas and be notified about relevant news around openHAB.</p>
            </div>
            <div class="col-md-6 img-portfolio">
                <a href="http://www.myopenhab.org">
                    <img class="img-responsive img-hover" src="/uploads/2016-12_myopenhab.png" alt="">
                </a>
                <h3>
                    <a href="http://www.myopenhab.org">myopenHAB Cloud Service</a>
                </h3>
                <p>myopenHAB is a publicly available instance of the new <a href="https://github.com/openhab/openhab-cloud#openhab-cloud">openHAB Cloud</a>. It provides remote access, smartphone notifications, IFTTT integration and an Amazon Echo skill.</p>
            </div>
</div>
 
None of all this would be possible without our members. Starting off with [7 founding members](http://www.kaikreuzer.de/2016/05/21/openhab-foundation/), we have reached 40 by now. I am especially happy for the support of our [5 corporate members](/members/memberlist.html), which each has a different background, like being a [smart home startup](/2016/home-ix), a [professional services provider](/2016/lewic), a [hardware manufacturer](/2016/pine64), an [IT consultancy company](/2016/qaware)  or an [Ambient Assisted Living (AAL) specialist](/2016/vss).

If you like our ideals and the value that we bring to the community, please [consider becoming a member](/members/membership.html) as well - we are ready to accept your application any time! I would like to specifically encourage all the people to join the foundation that have always wondered how they can give something back to the community while not being coders - this is now the opportunity for all of you! You can either decide to be a passive member and support us financially or to take an active role and help driving the foundation forward!
