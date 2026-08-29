<template>
  <div class="prop-container">
    <h4 class="prop-header" :id="name">
      <a :href="'#' + name" class="header-anchor" aria-hidden="true">#</a>
      <code class="prop-name">{{ name }}</code>
      <span>{{ label }}<span class="required" v-if="required" title="Required">*</span></span>
      <Badge :type="(type || '').toLowerCase()" :text="type" />
      <Badge v-if="context" type="info" :text="context" />
    </h4>
    <slot />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  name?: string
  type?: string
  required?: boolean | string
  label?: string
  context?: string
}>()
</script>

<style scoped>
h4.prop-header {
  margin-top: -3.5rem;
  padding-top: 4.6rem;
  margin-bottom: 0;
  font-size: 17px;
  border-bottom: 1px solid rgba(119, 119, 119, 0.2);
  padding-bottom: 5px;
}
.prop-name {
  background: #777;
  color: white;
  vertical-align: text-bottom;
  margin-right: 0.5rem;
}
.required {
  color: red;
  margin-left: 0.3rem;
}
:deep(.VPBadge) {
  font-size: 12px;
  margin-bottom: 1px;
  float: right;
  vertical-align: bottom !important;
}
</style>
