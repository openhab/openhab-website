---
layout: BlogPost
category: blog
title: openHAB 5.2 Release
author: Florian Hotze and others
date: "2026-07-05T20:00:00+01:00"
previewimage: /uploads/2026-07-05-openhab-5-2-release/header.webp
tags:
  - news
excerpt: >-
  Can you believe it's already been a year since the major release of openHAB 5.0? We are thrilled to introduce openHAB 5.2, packed with exciting new features, plenty of bug fixes and amazing new AI features!
---

Can you believe it's already been a year since the major release of openHAB 5.0?
We are thrilled to introduce openHAB 5.2, packed with exciting new features, plenty of bug fixes, and amazing new AI features!

But that's not all!
Following the release of [openHAB 5.1](/blog/2025-12-22-openhab-5-1-release.html) last winter with many "under the hood" changes, this release focuses on more user-facing changes.

This release includes only a small number of breaking changes, so upgrading from openHAB 5.1 should be really smooth.
Please review our [**official release notes**](https://github.com/openhab/openhab-distro/releases/tag/5.2.0) to learn about all breaking changes, new add-ons, enhancements, and fixes.

With that being said, we again want to share some statistics that show the progress in numbers and highlight some of the new features that you should not miss.

# Activity

<!-- https://github.com/florian-h05/github-stats?tab=readme-ov-file#contribution_stats -->
<!-- count changed lines: https://github.com/openhab/openhab-core/compare/5.1.0...5.2.0.RC2 -->
<!-- count total lines with cloc: https://github.com/AlDanial/cloc -->

Every new feature in openHAB 5.2 is a testament to the dedication of our vibrant, global community.
Activity across our GitHub repositories has been non-stop over these past few months.
Altogether, 141 contributors poured their efforts into a whopping 3.082 commits across our [GitHub repositories](https://github.com/openhab).

This big release includes impactful work across every part of the ecosystem:

- **[Core](https://github.com/openhab/openhab-core)**: 323 pull requests, including 110 enhancements and 58 bug fixes — adding 44.791 lines of new code.
- **[Add-ons](https://github.com/openhab/openhab-addons)**: 798 pull requests, including 223 enhancements and 233 bug fixes, resulting in 554.128 lines of new code.
- **[UIs](https://github.com/openhab/openhab-webui)**: 467 pull requests, including 108 enhancements and 175 bug fixes, totaling in 37.915 lines of new code.

Countless [other repositories](https://github.com/openhab) — from documentation and automation helper libraries to our mobile apps — also received a steady stream of contributions too extensive to list individually.

A massive thank you to everyone driving openHAB forward!

We also want to take the moment to shine a spotlight on our top code contributors for this release,
recognized for landing the most commits in their respective repositories:

<!-- https://github.com/florian-h05/github-stats?tab=readme-ov-file#contribution_stats -->

- Holger Friedrich ([@holgerfriedrich](https://github.com/holgerfriedrich)) for openHAB Core & Add-ons
- Laurent Garnier ([@lolodomo](https://github.com/lolodomo)) for openHAB Core
- Leo Siepel ([@lsiepel](https://github.com/lsiepel)) for openHAB Add-ons
- Jacob Laursen ([@jlaur](https://github.com/jlaur)) for openHAB Add-ons
- Florian Hotze ([@florian-h05](https://github.com/florian-h05)) for the openHAB Main UI & openHAB Core

Beyond coding, many of these individuals pull double duty as maintainers — evaluating pull requests, shaping architectural decisions, and mentoring newcomers.
As of this release, our team includes **43 active maintainers** across the project.

Whether you are squashing bugs, polishing the UI, refining documentation, or architecting entirely new integrations — every single contribution counts.

# Highlights

As you might have already noticed in the activity statistics, there was much development on openHAB – too much to list everything.
Please refer to the [**release notes**](https://github.com/openhab/openhab-distro/releases/tag/5.2.0) to check out what's new and noteworthy (e.g., breaking changes).

In the following sections, our maintainers and contributors introduce a section of new features you will not want to miss.

## Chat with openHAB

_Florian Hotze ([@florian-h05](https://github.com/florian-h05)), openHAB Maintainer_

## The openHAB MCP Server

_Dan Cunningham ([@digitaldan](https://github.com/digitaldan)), openHAB Maintainer_

The Model Context Protocol (MCP) is a standard way for AI assistants to connect with third party systems using the concept of tool calling, specially crafted API endpoints that are tailored for agentic use.
Our new MCP integration exposes your openHAB instance using a wide range of tools, giving AI agents a powerful way to control, edit, and monitor your home system.

The openHAB MCP server provides these capabilities:

- Query and control your Items using natural language.
- Find the right Items through the openHAB semantic model and fuzzy matching.
- Create rules, both traditional recurring and new one-shot rules.
- Build and edit Main UI pages, custom widgets, floor plans, and more.
- Manage static assets like icons and images.
- Manage Things, read logs, and reach the full REST API for advanced setups.

### Controlling openHAB

The server uses your semantic model and fuzzy matching to find the right rooms, equipment, and points, so a request for the office lights works even if the Item is named office ceiling light.
Ask it to dim the bedroom lights to 30 percent and set them to warm white, or set the living room to movie mode and tell you if anything is still on downstairs.
You can also ask general questions, like what doors are unlocked right now, or is the garage still open and quickly get an accurate state of your home.

### Creating rules

You can also ask your agent to create traditional recurring rules, like turning on the porch light every day at sunset, or run the sprinklers for twenty minutes on Monday, Wednesday, and Friday mornings
Additionally, the MCP server supports a new one-shot style rule for actions that should only fire once, like alarms or reminders.
Say turn off the patio heater in one hour, or turn on the outside lights tonight at 7, and the rule will automatically fire once and then delete itself.

### Editing Main UI

With the UI feature enabled, you can build and modify Main UI pages, floor plans, and custom widgets.
The MCP server is aware of every widget and all controls Main UI supports, so the assistant always knows the full set of components available and how each one is configured.
You can ask it to create a page or floor plan for a room, and it will lay out the design, place your devices on it, and style the page into something modern and beautiful.
Pair this with the optional static asset support and the assistant can create an interactive SVG, say a floor plan of your house, upload it, then use the UI tools to wire it into a page or floor plan so the rooms and devices on it become live controls.

### Advanced tools

For more involved setups the assistant can directly manage your Things and Items, as well as read your logs to help track down a problem.
And when you need something the other tools do not cover, it can optionally have access to the full openHAB REST API, which means anything openHAB exposes is available.

### Security and access

Access is built around an openHAB user token, either generated manually through the Main UI or using the built in OAuth connector, which allows a one click setup option using a web browser for popular clients that support it. Different tools can be enabled or disabled, allowing for granular control of access to sensitive areas like Thing configuration or full API access. Agents may connect directly to your local instance for clients that support local access, like Claude Code, Codex, or Antigravity. Other agents that need outside access like Claude, Gemini, and ChatGPT can use the optional myopenHAB connection option, which is automatically configured through our cloud service when enabled on your local instance.

You can read more about our new MCP binding, including tool use, client setup, and example use cases at the [MCP integration](/addons/integrations/mcp/) add-on page.

## Core Runtime Enhancements

### YAML Configuration Files for the UI

TODO @ ??

### YAML File Format for Rules & Rule Templates

TODO @Nadahar

### Protect your Secrets with Environment Variables

_Florian Hotze ([@florian-h05](https://github.com/florian-h05)), openHAB Maintainer_

Now that our new MCP integration makes it easier than ever before to work on your openHAB configuration with AI agents, you might have already wondered:

How to protect my secrets? How can I avoid that an AI agent accesses credentials and API keys?

To solve this issue, we've added support for referencing environment variables in Thing configuration.
Using the new `${ENV:MY_API_KEY}` syntax, you can pass the value of the `MY_API_KEY` environment variable to a Thing's configuration property.
This feature also comes handy when tracking your openHAB configuration with Git — keeping out secrets from Git history is common and best practice.

## Main UI Enhancements

Retaining the incredible momentum from openHAB 5.1 and the big Vue 3 & Framework7 upgrade, we've put much work into refactoring major parts of our codebase from JavaScript to TypeScript.
Making these "under the hood" changes allowed us to improve our overall code quality and stability, as well as enabling us to ship new features easier.

### Access Logs across the UI

_Jimmy Tanagra ([@jimtng](https://github.com/jimtng)), openHAB Maintainer_

TODO @jimtng

### Charting Made More Powerful

_Florian Hotze ([@florian-h05](https://github.com/florian-h05)), openHAB Maintainer_

Main UI includes a charting engine since its initial release with openHAB 3.0, and with openHAB 5.2 charts receive their biggest upgrade yet.
After refactoring all charting code to type-safe TypeScript code, we've addressed a ton of long-standing feature requests:

- **Display State Support:**<br/>
  A new series parameter has been added to format chart values according to the Item's state description.
  For UoM-enabled Items, this will display the chart data in the Item's display unit, and not the "system" unit.
- **More Sophisticated Tooltips:**<br/>
  Chart tooltips have been improved to display the unit of measurement or mapped Item states if defined through state descriptions.
- **Extended UI Support for Configuration:**<br/>
  It has always been possible to customize charts by providing ECharts options through the code tab.
  openHAB 5.2 finally adds UI support for configuring the most common series options, including:
  - color
  - series label position (for line/bar charts)
  - border radius (for bar charts)
  - x-axis style (label only, label & line, label & line & axis ticks)
  - y-axis style (axis line, minor lines, areas can be individually enabled or disabled)
- **Initial Period for Fixed Period Charts:**<br/>
  The initial period for fixed period charts can now be set.
- **Fixed Chart Periods over 1 Year:**<br/>
  Fixed chart periods 2 years, 3 years, and five years have been added, extended the chart range.
- **New Yearly Aggregation:**<br/>
  A new yearly aggregation has been added, allowing to compare several years in fixed period charts.

### Redesigned Persistence Configuration

TODO @mherwerge/@jsjames

### Persistence Status on the Item page

_Mark Herwege ([@mherwege](https://github.com/mherwege)), openHAB Maintainer_

TODO @mherwege

### Setup Wizard

_Mark Herwege ([@mherwege](https://github.com/mherwege)), openHAB Maintainer_

TODO @mherwege

## Add-on Enhancements

openHAB 5.2 ships TODO new-addons, marking a significant milestone by surpassing 500 add-ons:

TODO

But not only were new bindings added, some existing bindings also received massive improvements:

TODO

### JavaScript & Python Debugger Support

### Home Connect Direct Binding

## openHABian Enhancements

# Enjoy and Get in Touch

We are excited to see what you will do with the new features and improvements in openHAB 5.2 — your feedback is always welcome!
As always, our [community forum](https://community.openhab.org/) is there for questions, comments, and discussions.
Do not hesitate to get in touch, join our community, receive help, and share your experiences and use cases.
