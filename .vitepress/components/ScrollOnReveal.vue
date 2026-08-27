<template>
  <component :is="tag || 'div'" ref="el" :class="classes">
    <slot></slot>
  </component>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

export interface ScrollRevealOptions {
  delay?: number
  distance?: string
  duration?: number
  easing?: string
  interval?: number
  opacity?: number
  origin?: 'top' | 'right' | 'bottom' | 'left'
  scale?: number
  cleanup?: boolean
  container?: any
  desktop?: boolean
  mobile?: boolean
  reset?: boolean
  useDelay?: string
  viewFactor?: number
  viewOffset?: { top?: number; right?: number; bottom?: number; left?: number }
  afterReset?: (el: HTMLElement) => void
  afterReveal?: (el: HTMLElement) => void
  beforeReset?: (el: HTMLElement) => void
  beforeReveal?: (el: HTMLElement) => void
  [key: string]: any
}

const props = withDefaults(
  defineProps<{
    tag?: string
    classes?: string
    delay?: number
    duration?: number
    distance?: string
    origin?: 'top' | 'right' | 'bottom' | 'left'
    scale?: number
    interval?: number
    viewFactor?: number
    options?: ScrollRevealOptions
    selector?: string
  }>(),
  {
    tag: 'div',
    classes: '',
  }
)

const el = ref<HTMLElement | null>(null)
let srInstance: any = null

onMounted(async () => {
  if (!el.value) return
  try {
    const ScrollReveal = (await import('scrollreveal')).default
    srInstance = ScrollReveal()

    const opts: ScrollRevealOptions = {
      ...(props.scale !== undefined ? { scale: props.scale } : {}),
      ...(props.delay !== undefined ? { delay: props.delay } : {}),
      ...(props.duration !== undefined ? { duration: props.duration } : {}),
      ...(props.distance !== undefined ? { distance: props.distance } : {}),
      ...(props.origin !== undefined ? { origin: props.origin } : {}),
      ...(props.interval !== undefined ? { interval: props.interval } : {}),
      ...(props.viewFactor !== undefined ? { viewFactor: props.viewFactor } : {}),
      ...props.options,
    }

    if (props.selector) {
      const targets = el.value.querySelectorAll(props.selector)
      if (targets.length > 0) {
        srInstance.reveal(targets, opts, props.interval)
      }
    } else {
      srInstance.reveal(el.value, opts, props.interval)
    }
  } catch {
    // Ignore in SSR
  }
})

onUnmounted(() => {
  if (srInstance && el.value) {
    try {
      if (props.selector) {
        const targets = el.value.querySelectorAll(props.selector)
        if (targets.length > 0) {
          srInstance.clean(targets)
        }
      } else {
        srInstance.clean(el.value)
      }
    } catch {
      // Ignore
    }
  }
})
</script>
