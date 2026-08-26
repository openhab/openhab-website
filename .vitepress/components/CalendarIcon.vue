<template>
  <time :datetime="date" class="icon">
    <em>{{ weekday }}</em>
    <strong>{{ month }}</strong>
    <span>{{ day }}</span>
  </time>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  date: string
  endDate?: string
}>()

const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
const shortDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
const shortMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

const dateObj = computed(() => new Date(props.date))
const endDateObj = computed(() => (props.endDate ? new Date(props.endDate) : null))

const multipleDays = computed(() => {
  if (!endDateObj.value || isNaN(endDateObj.value.getTime())) return false
  return dateObj.value.getDate() !== endDateObj.value.getDate()
})

const multipleMonths = computed(() => {
  return multipleDays.value && endDateObj.value && dateObj.value.getMonth() !== endDateObj.value.getMonth()
})

const month = computed(() => {
  if (multipleMonths.value && endDateObj.value) {
    return `${shortMonths[dateObj.value.getMonth()]} - ${shortMonths[endDateObj.value.getMonth()]}`
  }
  return months[dateObj.value.getMonth()]
})

const weekday = computed(() => {
  if (multipleDays.value && endDateObj.value) {
    return `${shortDays[dateObj.value.getDay()]} - ${shortDays[endDateObj.value.getDay()]}`
  }
  return days[dateObj.value.getDay()]
})

const day = computed(() => {
  if (multipleDays.value && endDateObj.value) {
    return `${dateObj.value.getDate()} - ${endDateObj.value.getDate()}`
  }
  return dateObj.value.getDate()
})
</script>

<style scoped>
time.icon {
  font-size: 1em;
  display: block;
  position: relative;
  width: 7em;
  height: 8em;
  background-color: #fff;
  border-radius: 0.6em;
  box-shadow: 0 1px 0 #bdbdbd, 0 2px 0 #fff, 0 3px 0 #bdbdbd, 0 4px 0 #fff, 0 5px 0 #bdbdbd, 0 0 0 1px #bdbdbd;
  overflow: hidden;
  backface-visibility: hidden;
  transform: rotate(0deg) skewY(0deg);
  transform-origin: 50% 10%;
}

time.icon * {
  display: block;
  width: 100%;
  font-size: 1em;
  font-family: 'Open Sans', sans-serif;
  font-style: normal;
  text-align: center;
}

time.icon strong {
  position: absolute;
  top: 0;
  padding: 0.4em 0;
  color: #fff;
  background-color: #fd9f1b;
  border-bottom: 1px dashed #f37302;
  box-shadow: 0 2px 0 #fd9f1b;
}

time.icon em {
  position: absolute;
  bottom: 0.3em;
  color: #fd9f1b;
  font-weight: bold;
}

time.icon span {
  width: 100%;
  font-size: 2.3em;
  letter-spacing: -0.05em;
  padding-top: 1.1em;
  color: #2f2f2f;
}

time.icon:hover, time.icon:focus {
  animation: swing 0.6s ease-out;
}
</style>
