<template>
  <div class="home-icon-container">
    <img class="home-icon runs-everywhere" :class="{ current: current === 0 }" :src="withBase('/os/tux.svg')" alt="" />
    <img class="home-icon runs-everywhere" :class="{ current: current === 1 }" :src="withBase('/os/apple.svg')" alt="" />
    <img class="home-icon runs-everywhere" :class="{ current: current === 2 }" :src="withBase('/os/win10.svg')" alt="" />
    <img class="home-icon runs-everywhere" :class="{ current: current === 3 }" :src="withBase('/os/raspberry-pi.svg')" alt="" />
    <img class="home-icon runs-everywhere" :class="{ current: current === 4 }" :src="withBase('/os/docker.svg')" alt="" />
    <img class="home-icon frame" :src="withBase('/components/home/images/icons/empty.png')" alt="" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { withBase } from 'vitepress'

const current = ref(0)
let timer: any = null

onMounted(() => {
  timer = setInterval(() => {
    current.value = (current.value + 1) % 5
  }, 8000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped>
.home-icon-container {
  width: 150px;
  height: 150px;
  margin: 0 auto;
  position: relative;
}
.home-icon.runs-everywhere {
  position: absolute;
  width: 70px;
  height: 70px;
  left: 40px;
  top: 40px;
  opacity: 0;
  transition: opacity 1s ease-in-out;
}
.home-icon.frame {
  position: absolute;
  top: 0;
  left: 0;
  width: 150px;
  height: 150px;
  opacity: 1;
}
.home-icon.current {
  opacity: 1;
}
</style>
