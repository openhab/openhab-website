---
layout: BlogPost
category: blog
title: openHAB Garmin App
author: Robert Pollai
date: "2025-07-27T10:00:00+01:00"
previewimage: /uploads/2025-07-27-openhab-garmin-release/header.jpg
tags:
  - news
excerpt: >-
  The openHAB Garmin app has been released — bringing smart home control to your wrist or bike computer.
---
<style>
.garmin-screenshot-container {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;

  img {
    max-width: 300px !important;
    padding: 0.325em;
    background: white;
  }
}
</style>

The [openHAB 5.0 release](/blog/2025-07-21-openhab-5-0-release.html) is not even a week ago, but that doesn't hold us from announcing another exciting release:

The [openHAB Garmin app](/docs/apps/garmin/) has reached its first official release and is now officially available on the [Garmin Connect IQ Store](https://apps.garmin.com/apps/d83b5e1b-4a12-4eda-bbad-26f88952a959) — ready to bring smart home control to your wrist or bike computer!

No matter whether you want to quickly turn on the garden lighting from your wrist or open the garage door from your bike — **your sports watch or your bike computer now provide convenient access to openHAB**.

The openHAB Garmin app is **based on the familiar sitemaps**, thus requiring no additional configuration.
Its entry point is a glance view showing the sitemap name, along with a full-screen widget that presents the sitemap in a menu structure similar to the watch’s native interface:

<div class="garmin-screenshot-container">
  <img src="/uploads/2025-07-27-openhab-garmin-release/01-glance.png" alt="glance view"/>
  <img src="/uploads/2025-07-27-openhab-garmin-release/02-homepage.png" alt="homepage"/>
</div>

## Sitemaps Features

The app currently supports a carefully selected subset of the sitemap widgets:

- **Frame**
- **Text**
- **Group**
- **Switch**
- **Selection**
- **Setpoint**
- **Slider**

These widgets make it possible to display and control nearly all openHAB item types.
The app also supports dynamic sitemap features such as visibility conditions, custom colors, and icons.

The screenshots below show, clockwise from the top left: the menu structure for a sitemap page, the slider/setpoint widget, the rollershutter widget, and a multi-option switch.

<div class="garmin-screenshot-container">
  <img src="/uploads/2025-07-27-openhab-garmin-release/11-icons.png" alt="menu structure"/>
  <img src="/uploads/2025-07-27-openhab-garmin-release/07-slider-2.png" alt="slider/setpoint widget"/>
</div>
<div class="garmin-screenshot-container">
  <img src="/uploads/2025-07-27-openhab-garmin-release/06-switches-2-rollershutter-3.png" alt="roller shutter widget"/>
  <img src="/uploads/2025-07-27-openhab-garmin-release/06-switches-3-generic-2.png" alt="multi-option switch widget"/>
</div>

## Communication & Requirements

- The app communicates via the Garmin device's **Bluetooth Low Energy (BLE)** connection with the paired smartphone, that executes the network requests on the device's behalf.
- openHAB 5.0 supports the new app out-of-the-box, openHAB 4.3.x requires the installation of a backported REST API enhancement.
- **Connectivity behaviour differs by platform**:
  - On **iOS**, the app can connect to openHAB servers both via **HTTP** and **HTTPS**.
  - On **Android**, the app requires **HTTPS** with a **publicly trusted certificate** (self-signed certificates are not supported).
  - You can use [**myopenHAB.org**](https://myopenhab.org), which provides a secure and trusted HTTPS connection.

Due to the app's complexity and memory demands, it is supported only on devices with **sufficient memory** and a **modern Connect IQ API level**.
Even on supported devices, **large sitemaps** may approach system limits.
Significant development effort has gone into handling such cases gracefully.

## Supported Devices

Examples of supported Garmin devices include:

- **Fenix** (6 Pro and newer)
- **Epix 2 Pro**
- **Vivoactive** (5 and newer)
- **Forerunner** (recent models)
- **Edge** (e.g., 540, 1040 — yes, you can now open your garage from your bike computer!)

For a complete list of supported devices, visit the app's [Connect IQ Store page](https://apps.garmin.com/apps/d83b5e1b-4a12-4eda-bbad-26f88952a959).

## Documentation

For all wanting to give this a try, you can find the documentation where you'd expect it: [openHAB Docs — Garmin App](/docs/apps/garmin/).

## Roadmap

Development, of course, doesn't stop with version 1.0.0 — planned future features include:

- **Wi-Fi mode** (removing the dependency on a paired smartphone)
- **Improved support for larger sitemaps**

### Get Involved

For more details, feedback, and feature requests, join the discussion in the dedicated community forum category:

[openHAB Community – Garmin App Category](https://community.openhab.org/c/apps-services/garmin-app/)
