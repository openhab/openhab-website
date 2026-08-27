---
sidebar: false
layout: AboutPage
title: Who We Are
meta:
  - name: og:title
    content: openHAB - Who We Are
  - name: og:description
    content: a vendor and technology agnostic open source automation software for your home
---

<style>
.big-title {
  font-family: 'Open Sans', sans-serif;
  font-size: 2rem;
  font-weight: 400;
  text-align: center;
}
img.illustration {
  width: 50%;
  transform: translateX(50%);
}
@media (max-width: 719px) {
  img.illustration {
    width: 100%;
    transform: translateX(0);
  }
}
</style>

<h2 class="big-title">Our Vision and Philosophy</h2>

<!--
image source: https://pixabay.com/en/smart-home-home-technology-2769239/
license: CC0
-->
<img class="illustration" src="./images/smart-home-2769239_1920.jpg" />

There are many home automation solutions and Internet-of-Things (IoT) gadgets on the market, which are all useful on their own. They come with their own way on how to setup and configure devices and are perfect for their intended use cases.

The problem with all of these systems and devices is that these use cases are defined by the manufacturer - but as a user, you will quickly come up with wishes that are not supported out of the box or which require interaction between the different systems. openHAB fills this gap: It puts the user in the focus and allows him to do what he wants to do. It thus serves as an integration point for all your home automation needs and lets systems talk to each other across any vendor or protocol boundaries.

From our point of view, a commercial product can never stay up to date with all interesting things that can be integrated. So the only way to be sure that you do not bet on a dead horse is by using an open source solution that is maintained by a big community and which does not depend on the fate of a single company. openHAB is hence the best choice for a future-proof Smart Home setup.

Considering the user perspective also means caring for data privacy. With openHAB, all data (like sensor data or actuator commands) belongs to the user and it is up to him to decide, what data should potentially leave his house and where it is sent. Furthermore, there is no remote access possible, if it is not desired - everything works nicely within the intranet and does not even require an Internet connection. We therefore also like to call it the "Intranet of Things".



### Some Hacking Skills Required

openHAB is highly flexible and customizable, but this comes at a cost. You have to invest some time for learning its concepts and to set up an individual system tailored to your needs. Many parts of the setup require textual configuration, potentially accessing log files for debugging, etc. Therefore setting up openHAB is mainly a job for tech-savvy people - it is not a commercial off-the-shelf product that you plug in and that is ready to go.

Nonetheless, this only applies to the setup and configuration of the system, which is usually done by a single person in the household, while all other family members are merely using the system. And here is where openHAB shines: It is very stable, has apps for all different end devices, allows voice interaction, etc.



### Architectural Principles

openHAB does not try to replace existing solutions, but rather wants to enhance them - it can thus be considered as a system of systems. It therefore assumes that the sub-systems are setup and configured independently of openHAB as this is often a very specific and complex matter (including "pairing" processes, direct device links etc.). Instead, openHAB focuses on the "daily use" side of things and abstracts from the devices themselves.

A core concept for openHAB is the notion of an "item". An item is a data-centric functional atomic building block - you can think of it as an "capability". openHAB does not care whether an item (e.g. a temperature value) is related to a physical device or some "virtual" source like a web service or an calculation result. All features offered by openHAB are using this "item" abstraction, which means that you will not find any reference to device specific things (like IP addresses, IDs etc.) in automation rules, UI definitions and so on. This makes it perfectly easy to replace one technology by another without doing any changes to rules and UIs.

A very important aspect of openHAB's architecture is its modular design. It is very easy to add new features (like the integration with yet another system through a "binding") and you can add and remove such features at runtime. This modular approach has been a huge enabler for the active community around openHAB with many engaged contributors.



### Further Reading

Please see our [documentation](/docs/concepts/index.html) for further details about the concepts of openHAB, its features and possibilities.


<h2 id="community-guidelines" style="padding-top: 6rem" class="big-title">Community Guidelines</h2>


<!--
image source: https://pixabay.com/en/group-team-feedback-confirming-3354366/
license: CC0
-->
<img class="illustration" src="./images/group-3354366_1920.png" />

We want to keep the openHAB community awesome, growing and collaborative.
We need your help to keep it that way.
To help with this we've come up with some general guidelines for the community as a whole:

* **Be nice:** Be courteous, respectful and polite to fellow community members: no
  regional, racial, gender, or other abuse will be tolerated. We like nice people
  way better than mean ones!

* **Encourage diversity and participation:** Make everyone in our community
  feel welcome, regardless of their background and the extent of their
  contributions, and do everything possible to encourage participation in
  our community.

* **Keep it legal:** Basically, don't get us in trouble. Share only content that
  you own, do not share private or sensitive information, and don't break the
  law.

* **Stay on topic:** Make sure that you are posting to the correct channel
  and avoid off-topic discussions. Remember when you update an issue or
  respond to an email you are potentially sending to a large number of
  people.  Please consider this before you update.  Also remember that
  nobody likes spam.


