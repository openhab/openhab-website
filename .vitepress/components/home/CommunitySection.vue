<template>
  <div class="community">
    <h2 class="slide">
      <svg class="community-rocket-icon" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M2.81,14.12L5.64,11.29L8.17,10.79C11.39,6.41 17.55,4.22 19.78,4.22C19.78,6.45 17.59,12.61 13.21,15.83L12.71,18.36L9.88,21.19L9.17,17.66C7.76,17.66 7.76,17.66 7.05,16.95C6.34,16.24 6.34,16.24 6.34,14.83L2.81,14.12M5.64,16.95L7.05,18.36L4.39,21.03H2.97V19.61L5.64,16.95M4.22,15.54L5.46,15.71L3,18.16V16.74L4.22,15.54M8.29,18.54L8.46,19.78L7.26,21H5.84L8.29,18.54M13,9.5A1.5,1.5 0 0,0 11.5,11A1.5,1.5 0 0,0 13,12.5A1.5,1.5 0 0,0 14.5,11A1.5,1.5 0 0,0 13,9.5Z"
        />
      </svg>
      <span>Ready to join the community?</span>
    </h2>
    <p class="slide">
      The vibrant openHAB community contributes examples and tutorials on a daily basis and is happy to help you!
    </p>
    <div class="community-stats">
      <div class="community-stat slide-seq2">
        <div class="community-stat-icon">
          <svg style="width: 36px; height: 36px" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M17,12V3A1,1 0 0,0 16,2H3A1,1 0 0,0 2,3V17L6,13H16A1,1 0 0,0 17,12M21,6H19V15H6V17A1,1 0 0,0 7,18H18L22,22V7A1,1 0 0,0 21,6Z"
            />
          </svg>
        </div>
        <div class="count">{{ communityTopics }}</div>
        <div class="subtext">discussions</div>
      </div>
      <div class="community-stat slide-seq2">
        <div class="community-stat-icon">
          <svg style="width: 36px; height: 36px" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M17,11H15V9H17M13,11H11V9H13M9,11H7V9H9M20,2H4A2,2 0 0,0 2,4V22L6,18H20A2,2 0 0,0 22,16V4C22,2.89 21.1,2 20,2Z"
            />
          </svg>
        </div>
        <div class="count">{{ communityPosts }}</div>
        <div class="subtext">posts</div>
      </div>
      <div class="community-stat slide-seq2">
        <div class="community-stat-icon">
          <svg style="width: 36px; height: 36px" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M16,13C15.71,13 15.38,13 15.03,13.05C16.19,13.89 17,15 17,16.5V19H23V16.5C23,14.17 18.33,13 16,13M8,13C5.67,13 1,14.17 1,16.5V19H15V16.5C15,14.17 10.33,13 8,13M8,11A3,3 0 0,0 11,8A3,3 0 0,0 8,5A3,3 0 0,0 5,8A3,3 0 0,0 8,11M16,11A3,3 0 0,0 19,8A3,3 0 0,0 16,5A3,3 0 0,0 13,8A3,3 0 0,0 16,11Z"
            />
          </svg>
        </div>
        <div class="count">{{ communityMembers }}</div>
        <div class="subtext">members</div>
      </div>
    </div>
    <div class="join">
      <a :href="withBase('/about/showcase.html')" class="join-us-button slide-slow">Showcase ➜</a>
      <a target="_blank" href="https://community.openhab.org" class="join-us-button slide-slow" style="margin-top: 0" rel="noopener noreferrer">
        Join Us ➜
      </a>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { withBase } from 'vitepress'

const communityMembers = ref('22000+')
const communityTopics = ref('23000+')
const communityPosts = ref('240000+')

onMounted(async () => {
  try {
    const url = 'https://community.openhab.org/about.json'
    const resp = await fetch(url)
    const json = await resp.json()
    if (json?.about?.stats) {
      communityMembers.value = json.about.stats.users_count?.toLocaleString() || communityMembers.value
      communityTopics.value = json.about.stats.topics_count?.toLocaleString() || communityTopics.value
      communityPosts.value = json.about.stats.posts_count?.toLocaleString() || communityPosts.value
    }
  } catch {
    // CORS or offline fallback
  }
})
</script>

<style scoped>
.community {
  background-color: var(--vp-c-bg-alt, #ddd);
  display: flex;
  flex-direction: column;
  text-align: center;
  align-items: center;
  font-family: 'Open Sans', sans-serif;
  padding: 3rem 1rem;
}
.community h2 {
  margin: 1rem 0;
  font-size: 2.3rem;
  font-weight: 400;
  border: none;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}
.community-rocket-icon {
  width: 72px;
  height: 72px;
  display: block;
  margin: 0 auto 1rem auto;
}
.community p {
  margin: 0 2rem;
  color: var(--vp-c-text-2, #555);
}
.community-stats {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  align-self: center;
  font-weight: bold;
  margin: 2rem 0;
  gap: 1rem;
}
.community-stat {
  padding: 1rem 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}
.community-stat-icon {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  margin-bottom: 0.5rem;
}
.community-stat-icon svg {
  display: block;
  margin: 0 auto;
}
.community-stat .count {
  font-size: 24pt;
  text-align: center;
}
.community-stat .subtext {
  font-size: 14px;
  font-weight: normal;
  color: var(--vp-c-text-2, #666);
  text-align: center;
}
.join-us-button {
  margin: 1rem;
  display: inline-block;
  font-size: 1rem;
  color: #5599ff;
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  font-weight: bold;
  box-sizing: border-box;
  border: 2px solid #5599ff;
  text-decoration: none !important;
  transition: all 0.2s;
}
.join-us-button:hover {
  background-color: #5599ff;
  color: white;
  text-decoration: none !important;
}
@media (max-width: 768px) {
  .community-stats {
    flex-direction: column;
    margin: 1rem 0;
  }
}
</style>
