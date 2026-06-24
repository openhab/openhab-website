<template>
  <div>

    <alert-banner-section v-if="$page.frontmatter.alert" />

    <why-section />

    <openhabian-section />

    <cloud-section />

    <!-- <vs-code-section /> FIXME (masthead/parallax) -->

    <featured-addons />

    <open-source-section />

    <community-section />

    <events-section />

  </div>
</template>

<script>
import AlertBannerSection from './home/AlertBannerSection.vue'
import WhySection from './home/WhySection.vue'
import CloudSection from './home/CloudSection.vue'
import VsCodeSection from './home/VsCodeSection.vue'
import FeaturedAddons from './home/FeaturedAddons.vue'
import OpenhabianSection from './home/OpenhabianSection.vue'
import OpenSourceSection from './home/OpenSourceSection.vue'
import CommunitySection from './home/CommunitySection.vue'
import EventsSection from './home/EventsSection.vue'

export default {
  components: {
    AlertBannerSection,
    WhySection,
    CloudSection,
    VsCodeSection,
    FeaturedAddons,
    OpenhabianSection,
    OpenSourceSection,
    CommunitySection,
    EventsSection
  },
  mounted () {
    if (this.$sr) {
      const sr = this.$sr
      sr.reveal('.feature', { scale: 1.0 }, 200)
      sr.reveal('.slide', { scale: 1.0 })
      sr.reveal('.slide-slow', { scale: 1.0, duration: 1000, delay: 500 })
      sr.reveal('.slide-seq', { scale: 1.0, duration: 1000 }, 300)
      sr.reveal('.slide-seq2', { scale: 1.0, duration: 1000 }, 300)
      sr.reveal('.slide-seq3', { origin: 'left', distance: '10px', scale: 1.0, duration: 1000 }, 600)
      sr.reveal('.slide-seq4', { scale: 1.0, viewFactor: 0.0 }, 200)
      sr.reveal('.alert', { origin: 'left', distance: '40px', duration: 1200, scale: 1.0 })
    }
  }
}
</script>

<style>

</style>
