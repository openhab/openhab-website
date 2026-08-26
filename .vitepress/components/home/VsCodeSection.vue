<template>
  <div class="vscode-section">
    <div style="position: relative; height: 380px; background: transparent; width: 100%; overflow: hidden;">
      <ClientOnly>
        <parallax fixed>
          <img :src="withBase('/vscode.png')" alt="coding rules" />
        </parallax>
      </ClientOnly>
      <div class="vscode-text">
        <h2 class="slide">Easy &amp;<br />comfortable<br />configuration<br />editing.</h2>
        <a target="_blank" href="https://marketplace.visualstudio.com/items?itemName=openhab.openhab" class="get-extension-button slide" rel="noopener noreferrer">
          Get the VS Code Extension ➜
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
import parallax from '@lucien144/vue3-parallaxy'
</script>

<style scoped>
.vscode-section {
  color: white;
  display: flex;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  overflow: hidden;
  text-align: right;
  z-index: 1;
}
.vscode-text {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  text-align: center;
  right: 0;
  z-index: 12;
  padding: 5rem;
  min-width: 30%;
  background-color: rgba(0, 0, 0, 0.3);
}
.vscode-text h2 {
  font-size: 2.5em;
  font-weight: 300;
  border: none;
  margin-top: 0;
  text-shadow: 0px 0px 10px #666;
}
.get-extension-button {
  display: inline-block;
  font-size: 1rem;
  color: #fff;
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  box-sizing: border-box;
  background-color: rgba(0, 0, 0, 0.3);
  border: 1px solid #fff;
  text-decoration: none;
  transition: all 0.2s;
}
.get-extension-button:hover {
  background-color: #fff;
  color: black;
}
@media (max-width: 768px) {
  .vscode-text {
    left: 0;
    right: 0;
    background: rgba(0, 0, 0, 0.6);
    padding: 2rem;
  }
}
</style>
