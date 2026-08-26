<template>
  <div class="consent-banner" v-if="!consentAlreadySet">
    <p>
      We use cookies for analysis and insights.
      <a :href="withBase('/privacy.html')">Privacy Policy</a>
    </p>
    <button @click="reject">Reject</button>
    <button @click="accept">Accept</button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { withBase } from 'vitepress'

const consentAlreadySet = ref(true)
const consentValue = ref(-1)
let fetchScriptElement: HTMLScriptElement | null = null
let setupScriptElement: HTMLScriptElement | null = null

function updateCookie(val: number) {
  document.cookie = `Consent=${val}; path=/; max-age=31536000; ` + document.cookie
  consentValue.value = val
  consentAlreadySet.value = true

  if (val === 1) {
    addGoogleAnalyticsScript()
  } else {
    removeGoogleAnalyticsScript()
  }
}

function reject() {
  updateCookie(0)
}

function accept() {
  updateCookie(1)
}

function addGoogleAnalyticsScript() {
  if (!fetchScriptElement) {
    fetchScriptElement = document.createElement('script')
    fetchScriptElement.setAttribute('async', 'true')
    fetchScriptElement.setAttribute('src', 'https://www.googletagmanager.com/gtag/js?id=UA-47717934-1')
  }

  if (!setupScriptElement) {
    setupScriptElement = document.createElement('script')
    setupScriptElement.textContent = `
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-47717934-1', { 'anonymize_ip': true });
    `
  }

  if (!document.head.contains(fetchScriptElement)) {
    document.head.appendChild(fetchScriptElement)
  }
  if (!document.head.contains(setupScriptElement)) {
    document.head.appendChild(setupScriptElement)
  }
}

function removeGoogleAnalyticsScript() {
  if (fetchScriptElement && document.head.contains(fetchScriptElement)) {
    fetchScriptElement.remove()
  }
  if (setupScriptElement && document.head.contains(setupScriptElement)) {
    setupScriptElement.remove()
  }
}

onMounted(() => {
  const cookies = document.cookie
  const hasConsent = cookies.split('; ').some((cookie) => cookie.startsWith('Consent='))
  consentAlreadySet.value = hasConsent

  if (hasConsent) {
    const val = cookies
      .split('; ')
      .find((cookie) => cookie.startsWith('Consent='))
      ?.split('=')[1]
    consentValue.value = parseInt(val || '0', 10)
    if (consentValue.value === 1) {
      addGoogleAnalyticsScript()
    }
  }
})
</script>

<style scoped>
.consent-banner {
  position: fixed;
  bottom: 0px;
  z-index: 9999;
  box-sizing: border-box;
  width: 100%;
  min-height: 48px;
  padding: 8px 18px;
  display: flex;
  gap: 18px;
  color: #ffffff;
  background-color: #645862;
}

p,
button {
  font-family: 'Open Sans', sans-serif;
  font-size: 14px;
  line-height: 21px;
}

p {
  margin: 0;
  align-self: center;
  flex-grow: 1;
}

a {
  text-decoration: none;
  color: #f1d600;
}

button {
  align-self: center;
  min-width: 100px;
  height: 32px;
  border: none;
  border-radius: 5px;
  background-color: rgb(241, 214, 0);
  color: #000;
  font-weight: 500;
}

button:hover {
  cursor: pointer;
  filter: brightness(110%);
}

button:active {
  filter: brightness(90%);
}
</style>
