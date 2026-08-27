<template>
  <footer>
    <a href="#app">
      <img :src="withBase('/openhab-logo-square.svg')" class="footer-logo VPImage light" alt="openHAB logo" />
      <img :src="withBase('/openhab-logo-square-dark.svg')" class="footer-logo VPImage dark" alt="openHAB logo" />
    </a>
    <div class="legal">
      <span class="copyright">Copyright © {{ year }} by the openHAB Community and the openHAB Foundation e.V.</span>
      <br />
      <span class="legal-links">
        <a :href="withBase('/privacy.html')">Privacy policy</a> |
        <a :href="withBase('/imprint.html')">Imprint</a>
      </span>
    </div>
    <div class="social-icons">
      <a href="https://x.com/openhab" target="_blank" rel="noopener noreferrer" aria-label="X (Twitter)">
        <svg class="social-icon x" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
        </svg>
      </a>
      <a href="https://github.com/openhab" target="_blank" rel="noopener noreferrer" aria-label="GitHub">
        <svg class="social-icon github" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
          <path d="M10.369 24.837c0 0.125-0.144 0.225-0.325 0.225-0.206 0.019-0.35-0.081-0.35-0.225 0-0.125 0.144-0.225 0.325-0.225 0.188-0.019 0.35 0.081 0.35 0.225zM8.425 24.556c-0.044 0.125 0.081 0.269 0.269 0.306 0.162 0.063 0.35 0 0.387-0.125s-0.081-0.269-0.269-0.325c-0.162-0.044-0.344 0.019-0.387 0.144zM11.188 24.45c-0.181 0.044-0.306 0.163-0.287 0.306 0.019 0.125 0.181 0.206 0.369 0.163 0.181-0.044 0.306-0.163 0.287-0.288-0.019-0.119-0.188-0.2-0.369-0.181zM15.3 0.5c-8.669 0-15.3 6.581-15.3 15.25 0 6.931 4.362 12.863 10.594 14.95 0.8 0.144 1.081-0.35 1.081-0.756 0-0.387-0.019-2.525-0.019-3.837 0 0-4.375 0.938-5.294-1.863 0 0-0.713-1.819-1.737-2.288 0 0-1.431-0.981 0.1-0.962 0 0 1.556 0.125 2.412 1.613 1.369 2.413 3.662 1.719 4.556 1.306 0.144-1 0.55-1.694 1-2.106-3.494-0.387-7.019-0.894-7.019-6.906 0-1.719 0.475-2.581 1.475-3.681-0.162-0.406-0.694-2.081 0.162-4.244 1.306-0.406 4.313 1.688 4.313 1.688 1.25-0.35 2.594-0.531 3.925-0.531s2.675 0.181 3.925 0.531c0 0 3.006-2.1 4.313-1.688 0.856 2.169 0.325 3.838 0.163 4.244 1 1.106 1.613 1.969 1.613 3.681 0 6.031-3.681 6.512-7.175 6.906 0.575 0.494 1.063 1.431 1.063 2.9 0 2.106-0.019 4.712-0.019 5.225 0 0.406 0.288 0.9 1.081 0.756 6.25-2.075 10.488-8.006 10.488-14.938 0-8.669-7.031-15.25-15.7-15.25zM6.075 22.056c-0.081 0.063-0.063 0.206 0.044 0.325 0.1 0.1 0.244 0.144 0.325 0.063 0.081-0.063 0.063-0.206-0.044-0.325-0.1-0.1-0.244-0.144-0.325-0.063zM5.4 21.55c-0.044 0.081 0.019 0.181 0.144 0.244 0.1 0.063 0.225 0.044 0.269-0.044 0.044-0.081-0.019-0.181-0.144-0.244-0.125-0.038-0.225-0.019-0.269 0.044zM7.425 23.775c-0.1 0.081-0.063 0.269 0.081 0.387 0.144 0.144 0.325 0.163 0.406 0.063 0.081-0.081 0.044-0.269-0.081-0.387-0.138-0.144-0.325-0.163-0.406-0.063zM6.713 22.856c-0.1 0.063-0.1 0.225 0 0.369s0.269 0.206 0.35 0.144c0.1-0.081 0.1-0.244 0-0.387-0.088-0.144-0.25-0.206-0.35-0.125z"></path>
        </svg>
      </a>
      <a href="https://www.youtube.com/channel/UC7OK88DW0La_BJlcXZg8ydQ" target="_blank" rel="noopener noreferrer" aria-label="YouTube">
        <svg class="social-icon youtube" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
          <path d="M31.681 9.6c0 0-0.313-2.206-1.275-3.175-1.219-1.275-2.581-1.281-3.206-1.356-4.475-0.325-11.194-0.325-11.194-0.325h-0.012c0 0-6.719 0-11.194 0.325-0.625 0.075-1.987 0.081-3.206 1.356-0.963 0.969-1.269 3.175-1.269 3.175s-0.319 2.588-0.319 5.181v2.425c0 2.587 0.319 5.181 0.319 5.181s0.313 2.206 1.269 3.175c1.219 1.275 2.819 1.231 3.531 1.369 2.563 0.244 10.881 0.319 10.881 0.319s6.725-0.012 11.2-0.331c0.625-0.075 1.988-0.081 3.206-1.356 0.962-0.969 1.275-3.175 1.275-3.175s0.319-2.587 0.319-5.181v-2.425c-0.006-2.588-0.325-5.181-0.325-5.181zM12.694 20.15v-8.994l8.644 4.513-8.644 4.481z"></path>
        </svg>
      </a>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { withBase } from 'vitepress'

const year = new Date().getFullYear()

onMounted(async () => {
  try {
    const ScrollReveal = (await import('scrollreveal')).default
    const sr = ScrollReveal()
    sr.reveal('.footer-logo', { scale: 0.5 })
    sr.reveal('.legal', { scale: 1.0 })
    sr.reveal('.social-icons', { duration: 1000 })
  } catch {
    // Ignore if scrollreveal fails in SSR/certain environments
  }
})
</script>

<style scoped>
footer {
  border-top: 1px solid var(--vp-c-divider, #eaecef);
  margin-bottom: -2rem;
  background: var(--vp-c-bg-alt, #fafafc);
  padding: 3rem 2.5rem;
  text-align: center;
  color: var(--vp-c-text-2, #555555);
}

.footer-logo {
  width: 70px;
  height: 70px;
  margin: 0 auto;
  filter: grayscale(100%);
  opacity: 0.4;
}

html:not(.dark) .footer-logo.dark {
  display: none;
}

.dark .footer-logo.light {
  display: none;
}

.social-icons {
  margin-top: 3rem;
}

.social-icons .social-icon {
  display: inline-block;
  height: 35px;
  width: 35px;
  margin: 10px;
  fill: #777;
  transition: fill 0.2s;
}

.social-icons .social-icon:hover {
  fill: #333;
}

.dark .social-icons .social-icon:hover {
  fill: #fff;
}

.legal {
  font-size: 10pt;
  margin-top: 1rem;
}

.legal a {
  color: var(--vp-c-text-1, #000);
}

.legal .copyright {
  color: #777;
}

@media print {
  footer {
    background-color: transparent;
  }
  .social-icons,
  .legal-links,
  .footer-logo {
    display: none;
  }
}
</style>
