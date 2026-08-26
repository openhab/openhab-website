import { h } from 'vue'
import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import { enhanceAppWithTabs } from 'vitepress-plugin-tabs/client'
import './style.css'
import './openhab.css'

// Layouts
import HomeLayout from '../layouts/HomeLayout.vue'
import AboutPage from '../layouts/AboutPage.vue'
import BlogIndex from '../layouts/BlogIndex.vue'
import BlogPost from '../layouts/BlogPost.vue'
import Event from '../layouts/Event.vue'
import RedirectLayout from '../layouts/RedirectLayout.vue'

// General Components
import Footer from '../components/Footer.vue'
import DocPreviousVersions from '../components/DocPreviousVersions.vue'
import EditPageLink from '../components/EditPageLink.vue'
import AddonLogo from '../components/AddonLogo.vue'
import AddonSearch from '../components/AddonSearch.vue'
import BlogPostList from '../components/BlogPostList.vue'
import EventsList from '../components/EventsList.vue'
import CalendarIcon from '../components/CalendarIcon.vue'
import CommunityTutorials from '../components/CommunityTutorials.vue'
import ConsentBanner from '../components/ConsentBanner.vue'
import HomeSections from '../components/HomeSections.vue'
import IconsetDisplay from '../components/IconsetDisplay.vue'
import InlineImage from '../components/InlineImage.vue'
import InstallInstructions from '../components/InstallInstructions.vue'
import PropBlock from '../components/PropBlock.vue'
import PropDescription from '../components/PropDescription.vue'
import PropGroup from '../components/PropGroup.vue'
import PropOption from '../components/PropOption.vue'
import PropOptions from '../components/PropOptions.vue'
import ScrollOnReveal from '../components/ScrollOnReveal.vue'
import ThingDocRenderer from '../components/ThingDocRenderer.vue'

// Home Components
import AlertBannerSection from '../components/home/AlertBannerSection.vue'
import AlternativeToSection from '../components/home/AlternativeToSection.vue'
import CloudSection from '../components/home/CloudSection.vue'
import CommunitySection from '../components/home/CommunitySection.vue'
import EventsSection from '../components/home/EventsSection.vue'
import FeaturedAddons from '../components/home/FeaturedAddons.vue'
import IntegrateEverythingIcon from '../components/home/IntegrateEverythingIcon.vue'
import Jumbotron from '../components/home/Jumbotron.vue'
import OpenSourceSection from '../components/home/OpenSourceSection.vue'
import OpenhabianSection from '../components/home/OpenhabianSection.vue'
import RotatingGearsIcon from '../components/home/RotatingGearsIcon.vue'
import RunsEverywhereIcon from '../components/home/RunsEverywhereIcon.vue'
import VsCodeSection from '../components/home/VsCodeSection.vue'
import WhySection from '../components/home/WhySection.vue'

export default {
  extends: DefaultTheme,
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      'sidebar-nav-before': () => h(DocPreviousVersions),
      'doc-after': () => h(EditPageLink),
      'layout-bottom': () => h(Footer),
    })
  },
  enhanceApp({ app }) {
    enhanceAppWithTabs(app)
    app.config.globalProperties.$withBase = (url: string) => url

    // Register layouts
    app.component('HomeLayout', HomeLayout)
    app.component('AboutPage', AboutPage)
    app.component('BlogIndex', BlogIndex)
    app.component('BlogPost', BlogPost)
    app.component('Event', Event)
    app.component('RedirectLayout', RedirectLayout)

    // Register general components
    app.component('Footer', Footer)
    app.component('DocPreviousVersions', DocPreviousVersions)
    app.component('EditPageLink', EditPageLink)
    app.component('AddonLogo', AddonLogo)
    app.component('AddonSearch', AddonSearch)
    app.component('BlogPostList', BlogPostList)
    app.component('EventsList', EventsList)
    app.component('CalendarIcon', CalendarIcon)
    app.component('CommunityTutorials', CommunityTutorials)
    app.component('ConsentBanner', ConsentBanner)
    app.component('HomeSections', HomeSections)
    app.component('IconsetDisplay', IconsetDisplay)
    app.component('InlineImage', InlineImage)
    app.component('InstallInstructions', InstallInstructions)
    app.component('PropBlock', PropBlock)
    app.component('PropDescription', PropDescription)
    app.component('PropGroup', PropGroup)
    app.component('PropOption', PropOption)
    app.component('PropOptions', PropOptions)
    app.component('ScrollOnReveal', ScrollOnReveal)
    app.component('ThingDocRenderer', ThingDocRenderer)

    // Register home components
    app.component('AlertBannerSection', AlertBannerSection)
    app.component('AlternativeToSection', AlternativeToSection)
    app.component('CloudSection', CloudSection)
    app.component('CommunitySection', CommunitySection)
    app.component('EventsSection', EventsSection)
    app.component('FeaturedAddons', FeaturedAddons)
    app.component('IntegrateEverythingIcon', IntegrateEverythingIcon)
    app.component('Jumbotron', Jumbotron)
    app.component('OpenSourceSection', OpenSourceSection)
    app.component('OpenhabianSection', OpenhabianSection)
    app.component('RotatingGearsIcon', RotatingGearsIcon)
    app.component('RunsEverywhereIcon', RunsEverywhereIcon)
    app.component('VsCodeSection', VsCodeSection)
    app.component('WhySection', WhySection)
  },
} satisfies Theme
