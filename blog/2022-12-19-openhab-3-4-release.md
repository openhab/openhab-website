---
layout: BlogPost
category: blog
title: openHAB 3.4 Release
author: Kai Kreuzer
date: '2022-12-19T14:38:57+01:00'
previewimage: /uploads/winter22.jpg
tags:
  - news
excerpt: >-
  As every year before the festive season, we are happy to announce another
  stable release of openHAB that brings many additions, improvements and fixes!
---
openHAB continues to steadily evolve - since our summer release 3.3 the community continued contributing with undiminished speed, which has led to openHAB 3.4 being the best openHAB release ever.

You can find the full list of new add-ons, enhancements and fixes in our [**official release notes**](https://github.com/openhab/openhab-distro/releases/tag/3.4.0).

With that being said, we again want to share some statistics that show the progress in numbers.

# Activity

With the 3.4 release we have now reached more than 400 add-ons (417 to be precise) and over 3000 supported thing types (3102 is the exact number). There can't be much out there that is not supported by openHAB.

The new release brings 17 new add-ons from a wide range of applications - starting from another important vehicle integration with [MercedesMe](https://www.openhab.org/addons/bindings/mercedesme/) to smart gadgets like the connected meat thermometer [Meater](https://www.openhab.org/addons/bindings/meater/). In these 6 months of development, the add-ons repo counted 619 pull requests, resulting in more than 100,000 new lines of code.

The openHAB Core repo showed a similar high activity with 127 pull requests and more than 10,000 lines of code added as well as the UI repo with 64 pull requests and 25,000 new lines of code.

It is worth to mention that the times are over where I was one of the main contributors to the code base - the community definitely took the lead here by now and I would like to do a shout-out to our top 4 code contributors (having done the most commits in 2022):

* Jan (aka [J-N-K](https://github.com/J-N-K))
* Wouter (aka [wborn](https://github.com/wborn))
* Jacob (aka [jlaur](https://github.com/jlaur))
* Laurent (aka [lomodomo](https://github.com/lolodomo))

Besides contributing code, all of them are also maintainers and do an amazing job on code reviews and design discussions on Github issues and pull requests. This is what drives openHAB forward - a huge thanks to them as well as to all our other contributors!

# Highlights

As we pay special attention to backward compatibility, most of the changes are rather evolutionary than revolutionary and therefore there isn't a single big change to learn about. You are rather encouraged to go through the release notes yourself and see what matters most to you and your individual setup.

Nonetheless, a cluster of changes was done by Miguel (aka [GiviMAD](https://github.com/GiviMAD)) with regards to voice support, which he briefly summarizes here:

## Voice Updates

### Keyword spotting (KS) and Speech-to-Text (STT)

Recent contributions brought keyword spotting (KS) to openHAB. The mission of the KS services is to continually process an audio source in order to detect a configured keyword and to then start a dialog cycle (voice recognition -> command interpretation -> spoken response).

Two different KS services are available for openHAB right now: The [Porcupine Keyword Spotter](https://www.openhab.org/addons/voice/porcupineks/) and the [Rustpotter Keyword Spotter](https://www.openhab.org/addons/voice/rustpotterks/).

The former uses the PicoVoice product Porcupine and provides on-device wake word detection powered by deep learning. It relies on a closed source binary.
The voice data is processed offline, locally on your openHAB server by Porcupine, but it requires an internet connection to validate your service access keys.

The latter uses the open source library Rustpotter, which is a free and open-source keywords spotter written in rust. Rustpotter provides personal on-device wake word detection. You can generate a model for your keyword using wav audio samples. You can try its capabilities in this [web demo](https://givimad.github.io/rustpotter-worklet-demo/).

Once a KS service has detected a wake word, it is time for speech-to-text (SST) services of which openHAB by now offers three different options:

* The [Vosk STT Service](https://www.openhab.org/addons/voice/voskstt/) uses vosk-api to perform offline speech-to-text in openHAB. It is currently the only available offline STT service in openHAB.
* The [Google Cloud STT Service](https://www.openhab.org/addons/voice/googlestt/) uses the non-free Google Cloud Speech-to-Text API to transcript audio data to text. A user account has 60 minutes for transcribing audio free per month.
* The [IBM Watson STT Service](https://www.openhab.org/addons/voice/watsonstt/) uses the non-free IBM Watson Speech-to-Text API to transcript audio data to text. Its free tier offers 500 minutes for transcribing audio per month.

### Configurable listening melody for dialogs

openHAB 3.4 bring the possibility to add a listening melody for the dialogs. This way you are acoustically notified when the keyword has been spotted and the audio recognition is going to start. You write this melody in the Voice configuration of the Main UI using the note names and the character O or 0 for silence, you can raise the note one octave by adding the character “‘“, and customize the duration of the note adding the suffix “:ms” where ms is the note duration on milliseconds. A "synthesize audio" action and command have also been  added, so that you can send tone melodies to audio sinks from a rule or through the openHAB console.

<p align="center"><img style="max-width: 70%;" src="/uploads/2022-12_melody.jpg"/></p>

### HAB Speaker

To support these voice features, a dedicated utility has been added to the marketplace, [HABSpeaker](https://community.openhab.org/t/hab-speaker-dialog-processing-in-the-browser/140655). Its main target is to use the openHAB dialog processing capabilities from a browser. It simplifies the dialog configuration and merely requires a “speech-to-text” and “text-to-speech” services configured.
This simply UI may fit your needs if you don’t want to buy any specific hardware, but rather want to try out these features and learn about their capabilities.

<p align="center"><img style="max-width: 35%;" src="/uploads/2022-12_habspeaker.gif"/></p>

## Enjoy and get in touch!

We hope that you like the new release as much as we do - as always our [community forums](https://community.openhab.org/) are there for questions, comments and discussions. Do not hesitate to get in touch, join our community, receive help and share your experiences and use cases.

Last but not least I would like to mention that after two years of covid break, we are very much looking forward to meet many people in person again - we are going to have a stand at [FOSDEM 2023](https://fosdem.org/2023/) in early February and we can only recommend to everyone attending this biggest Open Source conference in Europe and meeting other Open Source and smart home enthusiasts. See you there and have a nice holiday break and a great start in the year 2023!
