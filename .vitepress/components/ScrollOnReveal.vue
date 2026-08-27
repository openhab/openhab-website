<template>
  <component :is="tag" ref="el" :class="classes">
    <slot />
  </component>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick, type ComponentPublicInstance } from 'vue'

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
  container?: HTMLElement | string
  desktop?: boolean
  mobile?: boolean
  reset?: boolean
  useDelay?: 'always' | 'onload' | 'once'
  viewFactor?: number
  viewOffset?: { top?: number; right?: number; bottom?: number; left?: number }
  afterReset?: (el: HTMLElement) => void
  afterReveal?: (el: HTMLElement) => void
  beforeReset?: (el: HTMLElement) => void
  beforeReveal?: (el: HTMLElement) => void
  [key: string]: unknown
}

interface Props {
  tag?: string
  classes?: string | string[] | Record<string, boolean>
  delay?: number
  duration?: number
  distance?: string
  origin?: 'top' | 'right' | 'bottom' | 'left'
  scale?: number
  interval?: number
  viewFactor?: number
  options?: ScrollRevealOptions
  selector?: string
}

const props = withDefaults(defineProps<Props>(), {
  tag: 'div',
  classes: '',
  options: () => ({}),
})

const el = ref<HTMLElement | ComponentPublicInstance | null>(null)
let srInstance: any = null
let observedElements: NodeListOf<Element> | HTMLElement[] = []

onMounted(async () => {
  await nextTick()

  const rawElement = el.value instanceof HTMLElement
      ? el.value
      : (el.value as ComponentPublicInstance)?.$el

  if (!rawElement || typeof window === 'undefined') return

  try {
    const scrollRevealModule = await import('scrollreveal')
    const ScrollReveal = scrollRevealModule.default || scrollRevealModule
    srInstance = ScrollReveal()

    const opts: ScrollRevealOptions = {
      ...(props.scale !== undefined ? { scale: props.scale } : {}),
      ...(props.delay !== undefined ? { delay: props.delay } : {}),
      ...(props.duration !== undefined ? { duration: props.duration } : {}),
      ...(props.distance !== undefined ? { distance: props.distance } : {}),
      ...(props.origin !== undefined ? { origin: props.origin } : {}),
      ...(props.viewFactor !== undefined ? { viewFactor: props.viewFactor } : {}),
      ...props.options,
    }

    if (props.selector) {
      const targets = rawElement.querySelectorAll(props.selector)
      if (targets.length > 0) {
        observedElements = targets
        srInstance.reveal(targets, opts, props.interval)
      }
    } else {
      observedElements = [rawElement]
      srInstance.reveal(rawElement, opts, props.interval)
    }
  } catch (error) {
    // SSR fallback or missing client context
    console.warn('[ScrollReveal] Initialization failed:', error)
  }
})

onUnmounted(() => {
  if (srInstance && observedElements.length > 0) {
    try {
      srInstance.clean(observedElements)
    } catch {
      // Ignored cleanup errors
    } finally {
      srInstance = null
      observedElements = []
    }
  }
})
</script>
