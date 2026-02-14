<template>
  <time :datetime="date" class="icon">
    <em>{{ weekday }}</em>
    <strong>{{ month }}</strong>
    <span>{{ day }}</span>
  </time>
</template>

<style>
/* Styling courtesy of http://www.sitepoint.com/calendar-icon-css3/ by @craigbuckler */

time.icon {
  font-size: 1em; /* change icon size */
  display: block;
  position: relative;
  width: 7em;
  height: 8em;
  background-color: #fff;
  border-radius: 0.6em;
  box-shadow: 0 1px 0 #bdbdbd, 0 2px 0 #fff, 0 3px 0 #bdbdbd, 0 4px 0 #fff, 0 5px 0 #bdbdbd, 0 0 0 1px #bdbdbd;
  overflow: hidden;
  -webkit-backface-visibility: hidden;
  -webkit-transform: rotate(0deg) skewY(0deg);
  -webkit-transform-origin: 50% 10%;
  transform-origin: 50% 10%;
}

time.icon * {
  display: block;
  width: 100%;
  font-size: 1em;
  /* font-weight: bold; */
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
  -webkit-animation: swing 0.6s ease-out;
  animation: swing 0.6s ease-out;
}
</style>

<script>
const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
const shortDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
const shortMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

export default {
  props: ['date', 'endDate'],
  data () {
    const date = new Date(this.date)
    const endDate = new Date(this.endDate)
    const multiple_days = !isNaN(endDate) && (date.getDate() !== endDate.getDate())
    const multiple_months = multiple_days && (date.getMonth() !== endDate.getMonth())
    return {
      month: (multiple_months) ? shortMonths[date.getMonth()] + ' - ' + shortMonths[endDate.getMonth()] : months[date.getMonth()],
      weekday: (multiple_days) ? shortDays[date.getDay()] + '	- ' + shortDays[endDate.getDay()] : days[date.getDay()],
      day: (multiple_days) ? date.getDate() + '	- ' + endDate.getDate() : date.getDate()
    }
  }
}
</script>
