<template>
  <div>
    <h5>Options:</h5>
    <dl class="prop-options">
      <slot />
    </dl>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped>
dl.prop-options {
  border-radius: 0px 0px 5px 5px;
  padding-left: 5px;
  margin-bottom: 15px;
  font-size: 14px;
  columns: 1;
  column-gap: 0px;
}
:deep(div) {
  margin-bottom: 0.3rem;
  display: block;
  break-inside: avoid;
}
:deep(dt) {
  padding-left: 5px;
  margin: 0px;
  display: inline-block;
  break-after: avoid;
}
:deep(dd) {
  break-after: avoid;
}
@media (min-width: 900px) {
  dl.prop-options {
    columns: 2;
    column-gap: 60px;
  }
}
@media (min-width: 1200px) {
  dl.prop-options {
    columns: 3;
    column-gap: 80px;
  }
}
</style>
