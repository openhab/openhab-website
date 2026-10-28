<template>
  <component
    :is="tag"
    ref="el"
    :class="[
      classes,
      'v-scroll-reveal',
      {
        'v-sr-hidden': !isMounted && effectiveSsrHidden,
        'v-sr-ready': isMounted,
      },
    ]"
    :style="ssrStyle"
    :data-sr-ready="isMounted ? 'true' : 'false'"
  >
    <slot />
  </component>
</template>

<script setup lang="ts">
import {
  ref,
  computed,
  watch,
  onMounted,
  onUnmounted,
  nextTick,
  type ComponentPublicInstance,
} from 'vue'

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
  container?: HTMLElement | string | null
  desktop?: boolean
  mobile?: boolean
  reset?: boolean
  rootMargin?: string
  ssrHidden?: boolean
  useDelay?: 'always' | 'onload' | 'once'
  viewFactor?: number
  viewOffset?: { top?: number; right?: number; bottom?: number; left?: number }
  afterReset?: (el: HTMLElement) => void
  afterReveal?: (el: HTMLElement) => void
  beforeReset?: (el: HTMLElement) => void
  beforeReveal?: (el: HTMLElement) => void
  [key: string]: unknown
}

export interface Props {
  tag?: string
  classes?: string | string[] | Record<string, boolean>
  delay?: number
  duration?: number
  distance?: string
  origin?: 'top' | 'right' | 'bottom' | 'left'
  scale?: number
  interval?: number
  easing?: string
  opacity?: number
  viewFactor?: number
  rootMargin?: string
  options?: ScrollRevealOptions
  selector?: string
  reset?: boolean
  cleanup?: boolean
  ssrHidden?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  tag: 'div',
  classes: '',
  options: () => ({}),
})

const el = ref<HTMLElement | ComponentPublicInstance | null>(null)
const isMounted = ref(false)

let observer: IntersectionObserver | null = null
let mutationObserver: MutationObserver | null = null
let observedElements: HTMLElement[] = []
const revealedElements = new Set<HTMLElement>()
const cleanupTimeouts = new Map<HTMLElement, number>()

const effectiveDuration = computed(() => props.options.duration ?? props.duration ?? 600)
const effectiveDelay = computed(() => props.options.delay ?? props.delay ?? 0)
const effectiveDistance = computed(() => props.options.distance ?? props.distance ?? '0px')
const effectiveOrigin = computed(() => props.options.origin ?? props.origin ?? 'bottom')
const effectiveScale = computed(() => props.options.scale ?? props.scale ?? 1)
const effectiveInterval = computed(() => props.options.interval ?? props.interval ?? 0)
const effectiveEasing = computed(() => props.options.easing ?? props.easing ?? 'cubic-bezier(0.5, 0, 0, 1)')
const effectiveOpacity = computed(() => props.options.opacity ?? props.opacity ?? 0)
const effectiveReset = computed(() => props.options.reset ?? props.reset ?? false)
const effectiveCleanup = computed(() => props.options.cleanup ?? props.cleanup ?? false)
const effectiveSsrHidden = computed(() => props.options.ssrHidden ?? props.ssrHidden ?? false)
const effectiveViewFactor = computed(() => {
  const vf = props.options.viewFactor ?? props.viewFactor ?? 0.0
  return Math.max(0, Math.min(1, vf))
})

const containerElement = computed<HTMLElement | null>(() => {
  if (typeof document === 'undefined') return null
  const c = props.options.container
  if (!c) return null
  if (typeof c === 'string') {
    return document.querySelector<HTMLElement>(c)
  }
  if (c instanceof HTMLElement) {
    return c
  }
  return null
})

const effectiveRootMargin = computed(() => {
  if (props.rootMargin) return props.rootMargin
  if (props.options.rootMargin) return props.options.rootMargin

  const vo = props.options.viewOffset
  if (vo) {
    const formatOffset = (val?: number | string) => {
      if (val === undefined || val === null || val === 0 || val === '0' || val === '0px') {
        return '0px'
      }
      if (typeof val === 'number') {
        return val === 0 ? '0px' : `${-val}px`
      }
      const parsed = parseFloat(val)
      if (isNaN(parsed) || parsed === 0) return '0px'
      const unit = val.replace(/^[+-]?[\d.]+/, '').trim() || 'px'
      return `${-parsed}${unit}`
    }

    const top = formatOffset(vo.top)
    const right = formatOffset(vo.right)
    const bottom = formatOffset(vo.bottom)
    const left = formatOffset(vo.left)

    return `${top} ${right} ${bottom} ${left}`
  }

  return '0px'
})

const ssrStyle = computed(() => {
  if (!isMounted.value && effectiveSsrHidden.value) {
    return {
      opacity: String(effectiveOpacity.value),
      '--sr-initial-opacity': String(effectiveOpacity.value),
    }
  }
  return undefined
})

function getInitialTransform(
  origin: 'top' | 'right' | 'bottom' | 'left',
  distance: string,
  scale: number
): string {
  const transforms: string[] = []
  const distVal = distance.trim()
  const hasDistance = distVal !== '0' && distVal !== '0px' && distVal !== ''

  if (hasDistance) {
    switch (origin) {
      case 'top':
        transforms.push(`translateY(-${distVal})`)
        break
      case 'bottom':
        transforms.push(`translateY(${distVal})`)
        break
      case 'left':
        transforms.push(`translateX(-${distVal})`)
        break
      case 'right':
        transforms.push(`translateX(${distVal})`)
        break
    }
  }

  if (scale !== 1) {
    transforms.push(`scale(${scale})`)
  }

  return transforms.length > 0 ? transforms.join(' ') : 'none'
}

const currentInitialTransform = computed(() =>
  getInitialTransform(
    effectiveOrigin.value,
    effectiveDistance.value,
    effectiveScale.value
  )
)

function isPrefersReducedMotion(): boolean {
  return (
    typeof window !== 'undefined' &&
    window.matchMedia('(prefers-reduced-motion: reduce)').matches
  )
}

function isDeviceEnabled(): boolean {
  if (typeof window === 'undefined') return true
  const isMobile = window.matchMedia('(max-width: 768px)').matches
  if (props.options.mobile === false && isMobile) return false
  if (props.options.desktop === false && !isMobile) return false
  return true
}

function getRawElement(): HTMLElement | null {
  if (!el.value) return null
  if (el.value instanceof HTMLElement) {
    return el.value
  }
  return (el.value as ComponentPublicInstance)?.$el as HTMLElement | null
}

function applyInitialStyles(target: HTMLElement, index: number, initialTransform: string) {
  if (isPrefersReducedMotion() || !isDeviceEnabled()) {
    target.style.opacity = '1'
    target.style.transform = 'none'
    return
  }

  const delayMs = effectiveDelay.value + index * effectiveInterval.value
  const durationMs = effectiveDuration.value
  const easing = effectiveEasing.value

  target.style.opacity = String(effectiveOpacity.value)
  if (initialTransform !== 'none') {
    target.style.transform = initialTransform
  }
  target.style.transition = `opacity ${durationMs}ms ${easing} ${delayMs}ms, transform ${durationMs}ms ${easing} ${delayMs}ms`
  target.style.willChange = 'opacity, transform'
}

function cleanUpElementStyles(target: HTMLElement) {
  target.style.willChange = ''
  if (effectiveCleanup.value) {
    target.style.transition = ''
  }
}

function clearElementCleanup(target: HTMLElement) {
  const timer = cleanupTimeouts.get(target)
  if (timer !== undefined) {
    clearTimeout(timer)
    cleanupTimeouts.delete(target)
  }
}

function revealElement(target: HTMLElement) {
  revealedElements.add(target)

  if (typeof props.options.beforeReveal === 'function') {
    props.options.beforeReveal(target)
  }

  target.style.opacity = '1'
  target.style.transform = 'none'

  // Clean up willChange (and transition if cleanup option is enabled) on transitionend
  clearElementCleanup(target)

  const hasTransform = currentInitialTransform.value !== 'none'
  let pendingTransitions = hasTransform ? 2 : 1

  const onTransitionEnd = (event: TransitionEvent) => {
    if (event.target !== target) return
    if (event.propertyName !== 'opacity' && event.propertyName !== 'transform') return

    pendingTransitions--
    if (pendingTransitions <= 0) {
      target.removeEventListener('transitionend', onTransitionEnd)
      clearElementCleanup(target)
      cleanUpElementStyles(target)
    }
  }

  target.addEventListener('transitionend', onTransitionEnd)

  // Fallback timeout in case transitionend does not fire (zero duration, tab hidden, etc.)
  const targetIndex = observedElements.indexOf(target)
  const delayMs = effectiveDelay.value + Math.max(0, targetIndex) * effectiveInterval.value
  const totalDuration = delayMs + effectiveDuration.value + 150

  const timerId = window.setTimeout(() => {
    target.removeEventListener('transitionend', onTransitionEnd)
    clearElementCleanup(target)
    cleanUpElementStyles(target)
  }, totalDuration)

  cleanupTimeouts.set(target, timerId)

  if (typeof props.options.afterReveal === 'function') {
    props.options.afterReveal(target)
  }
}

function resetElement(target: HTMLElement, initialTransform: string) {
  clearElementCleanup(target)
  revealedElements.delete(target)

  if (typeof props.options.beforeReset === 'function') {
    props.options.beforeReset(target)
  }

  const durationMs = effectiveDuration.value
  const easing = effectiveEasing.value

  // Re-enable transition and willChange for reset animation
  target.style.willChange = 'opacity, transform'
  target.style.transition = `opacity ${durationMs}ms ${easing}, transform ${durationMs}ms ${easing}`
  target.style.opacity = String(effectiveOpacity.value)
  if (initialTransform !== 'none') {
    target.style.transform = initialTransform
  }

  if (typeof props.options.afterReset === 'function') {
    props.options.afterReset(target)
  }
}

function setupTargets() {
  const rawElement = getRawElement()
  if (!rawElement || typeof window === 'undefined') return

  const allTargets = props.selector
    ? Array.from(rawElement.querySelectorAll<HTMLElement>(props.selector))
    : [rawElement]

  // Prune targets that were removed from the DOM
  observedElements = observedElements.filter((target) => {
    if (!allTargets.includes(target) || !document.body.contains(target)) {
      observer?.unobserve(target)
      clearElementCleanup(target)
      revealedElements.delete(target)
      return false
    }
    return true
  })

  // Set up and observe targets
  allTargets.forEach((target) => {
    const targetIndex = allTargets.indexOf(target)

    if (!observedElements.includes(target)) {
      observedElements.push(target)

      if (!isDeviceEnabled() || isPrefersReducedMotion()) {
        target.style.opacity = '1'
        target.style.transform = 'none'
        return
      }

      applyInitialStyles(target, targetIndex, currentInitialTransform.value)
      observer?.observe(target)
    }
  })
}

function initObserver() {
  if (typeof IntersectionObserver === 'undefined') return

  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        const target = entry.target as HTMLElement
        if (entry.isIntersecting) {
          revealElement(target)
          if (!effectiveReset.value) {
            observer?.unobserve(target)
          }
        } else if (effectiveReset.value && revealedElements.has(target)) {
          resetElement(target, currentInitialTransform.value)
        }
      })
    },
    {
      root: containerElement.value,
      rootMargin: effectiveRootMargin.value,
      threshold: effectiveViewFactor.value,
    }
  )
}

function teardown() {
  if (mutationObserver) {
    mutationObserver.disconnect()
    mutationObserver = null
  }

  if (observer) {
    observer.disconnect()
    observer = null
  }

  observedElements.forEach((target) => {
    clearElementCleanup(target)
  })
}

function reinitialize() {
  teardown()
  initObserver()

  const rawElement = getRawElement()
  if (!rawElement || typeof window === 'undefined') return

  const allTargets = props.selector
    ? Array.from(rawElement.querySelectorAll<HTMLElement>(props.selector))
    : [rawElement]

  observedElements = []

  allTargets.forEach((target) => {
    const targetIndex = allTargets.indexOf(target)
    observedElements.push(target)

    if (!isDeviceEnabled() || isPrefersReducedMotion()) {
      target.style.opacity = '1'
      target.style.transform = 'none'
      return
    }

    if (revealedElements.has(target)) {
      if (effectiveReset.value) {
        observer?.observe(target)
      }
    } else {
      applyInitialStyles(target, targetIndex, currentInitialTransform.value)
      observer?.observe(target)
    }
  })

  if (props.selector && typeof MutationObserver !== 'undefined') {
    mutationObserver = new MutationObserver(() => {
      setupTargets()
    })
    mutationObserver.observe(rawElement, { childList: true, subtree: true })
  }
}

onMounted(async () => {
  await nextTick()
  isMounted.value = true

  const rawElement = getRawElement()
  if (!rawElement || typeof window === 'undefined') return

  initObserver()
  setupTargets()

  if (props.selector && typeof MutationObserver !== 'undefined') {
    mutationObserver = new MutationObserver(() => {
      setupTargets()
    })
    mutationObserver.observe(rawElement, { childList: true, subtree: true })
  }
})

watch(
  [
    () => props.options,
    () => props.delay,
    () => props.duration,
    () => props.distance,
    () => props.origin,
    () => props.scale,
    () => props.interval,
    () => props.easing,
    () => props.opacity,
    () => props.viewFactor,
    () => props.rootMargin,
    () => props.reset,
    () => props.cleanup,
    () => props.selector,
    () => props.ssrHidden,
  ],
  () => {
    if (isMounted.value) {
      reinitialize()
    }
  },
  { deep: true }
)

onUnmounted(() => {
  teardown()

  observedElements.forEach((target) => {
    clearElementCleanup(target)
    target.style.opacity = ''
    target.style.transform = ''
    target.style.transition = ''
    target.style.willChange = ''
  })
  observedElements = []
  revealedElements.clear()
})
</script>

<style scoped>
@media (scripting: none) {
  .v-sr-hidden {
    opacity: 1 !important;
    transform: none !important;
  }
}
</style>
