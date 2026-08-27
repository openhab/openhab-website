---
layout: BlogPost
category: blog
title: openHAB 3.1 Release
author: Kai Kreuzer
date: '2021-06-28T11:00:00+01:00'
previewimage: /uploads/2021-06_summer.jpg
tags:
  - news
excerpt: >-
  Our summer release openHAB 3.1 is out! It improves many details over 3.0 and again comes with a huge list of new add-ons.
---
Our summer release openHAB 3.1 is out! It improves many details over 3.0 and again comes with a huge list of new add-ons.

<!-- more -->

Releasing openHAB 3.0 end of last year was a major step for all contributors and users - the new Main UI brought a fresh and modern touch to the UI of openHAB and also heavily increased the UX. We received very positive feedback on it from our community and the 3.x release is well appreciated. This can also be seen by the fact that many followed our appeal to help translating it to other languages. As a result, openHAB now features the (non-admin parts of the) Main UI in 19 languages (besides obvious ones like German, Dutch, French, Spanish, Russian and Polish also e.g. Simplified Chinese, Luxembourgish and Latvian). And there is more to come - if your language is missing, please help and visit https://translate.openhab.org/.

<p align="center"><img src="/uploads/2021-06_flags.jpg"/></p>

Besides translations, the Main UI was [improved in many further aspects](https://github.com/openhab/openhab-distro/releases/tag/3.1.0#uis): A long list of small bugs has been fixed and a likewise impressive list of new small features were added - this time as an evolution and stabilization rather than a revolution.

## Core Runtime

Similar to the UI, the core runtime saw a phase of [stabilization, bug fixing and many small improvements](https://github.com/openhab/openhab-distro/releases/tag/3.1.0#core-runtime). It has absolutely proven to be production ready and together with the improvements in the UI, the 3.1 release should be a safe harbor for everyone that generally avoids dot-zero releases and still runs openHAB 2.x.

A new feature in the core runtime that I'd like to highlight is that it now exposes metrics through [Micrometer APIs](https://micrometer.io/). Together with the new [Metrics add-on](https://www.openhab.org/addons/integrations/metrics/), this allows openHAB to be integrated with Prometheus monitoring or alternatively directly pushing the metrics to InfluxDB and Grafana. 

<p align="center"><img src="/uploads/2021-06_metrics.png"/></p>

## Add-ons

The major efforts of our community members continues to be on increasing the number of devices, systems and platforms openHAB integrates with - openHAB 3.1 includes 42 new add-ons, rocketing us to more than 350 add-ons being available now. The additions have a wide range and I recommend having a look at the [list in the release notes](https://github.com/openhab/openhab-distro/releases/tag/3.1.0#newaddons).

White goods have gained popularity and are seeing major support in openHAB through the addition of the [BSH Home Connect](https://www.openhab.org/addons/bindings/homeconnect/) ecosystem and the new cloud-integrated range of [Miele devices](https://www.openhab.org/addons/bindings/mielecloud/). Special shout-out to Miele here for having actively participated in the development of the binding!

Integrating white goods makes a lot of sense for energy management use cases - which have their other correspondence in energy supply and monitoring add-ons, such as [Solarwatt](https://www.openhab.org/addons/bindings/solarwatt/), [Enphase](https://www.openhab.org/addons/bindings/enphase/), [MEC Meter](https://www.openhab.org/addons/bindings/mecmeter/) or [SEMSPortal](https://www.openhab.org/addons/bindings/semsportal/).

<p align="center"><img src="/uploads/2021-06_pv.jpg"/></p>

## Outlook

We will keep our bi-annual release cycle so that we are aiming for openHAB 3.2 towards the end of this year. There are a few features in the pipeline that you can already look forward to: We will finally have a replacement for the Eclipse IoT Marketplace to easily share and install 3rd-party add-ons. Also, rule templates will see much stronger support and the update process can optionally be done through the UI - so stay tuned and help developing these and other cool features!
