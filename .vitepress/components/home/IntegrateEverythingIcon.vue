<template>
  <div class="home-icon-container">
    <img class="home-icon" :class="{ current: current === 0 }" src="./images/icons/light.png" alt="" />
    <img class="home-icon" :class="{ current: current === 1 }" src="./images/icons/temperature.png" alt="" />
    <img class="home-icon" :class="{ current: current === 2 }" src="./images/icons/shutters.png" alt="" />
    <img class="home-icon" :class="{ current: current === 3 }" src="./images/icons/camera.png" alt="" />
    <img class="home-icon" :class="{ current: current === 4 }" src="./images/icons/lock.png" alt="" />
    <img class="home-icon" :class="{ current: current === 5 }" src="./images/icons/key.png" alt="" />
    <img class="home-icon" :class="{ current: current === 6 }" src="./images/icons/homecinema.png" alt="" />
    <img class="home-icon" :class="{ current: current === 7 }" src="./images/icons/wifi.png" alt="" />
    <img class="home-icon" :class="{ current: current === 8 }" src="./images/icons/tv.png" alt="" />
    <img class="home-icon" :class="{ current: current === 9 }" src="./images/icons/washingmachine.png" alt="" />
    <img class="home-icon" :class="{ current: current === 10 }" src="./images/icons/car.png" alt="" />
    <img class="home-icon frame" src="./images/icons/empty.png" alt="" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const current = ref(0)
let timer: any = null

onMounted(() => {
  timer = setInterval(() => {
    current.value = (current.value + 1) % 11
  }, 5000)
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
  flex-shrink: 0;
}
.home-icon {
  position: absolute;
  top: 0;
  left: 0;
  width: 150px;
  height: 150px;
  opacity: 0;
  transition: opacity 1s ease-in-out;
}
.home-icon.frame {
  opacity: 1;
}
.home-icon.current {
  opacity: 1;
}
</style>
