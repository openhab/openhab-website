<template>
  <div class="jumbotron">
    <div class="hero-image"></div>
    <ClientOnly><img draggable="false" class="jumbotron-pattern" src="/pattern.png" alt=""></ClientOnly>
    <div class="hero-content">
      <div class="white-logo"><ClientOnly><img src="/openhab-logo.svg" class="white-logo" /></ClientOnly></div>
      <h1 class="hero">empowering the smart home</h1>
      <h2 class="lead">a vendor and technology agnostic open source automation software for your home</h2>
      <h3> information section for new users here...</h3>
      <router-link to="docs/" class="action-button">Introduction ➜</router-link>
      <a class="demo-button" target="_blank" href="https://demo.openhab.org">Try It ➜</a>
    </div>
    <div class="phone">
      <div class="iframe-wrapper">
        <iframe src="/demo" frameborder="0" scrolling="no" />
      </div>
    </div>
  </div>
</template>

<style lang="stylus">
.jumbotron
  background $headerColor
  position absolute
  top 0
  left 0
  right 0
  // min-height 600px
  height 760px
  display flex
  justify-content center
  align-items top
  .jumbotron-pattern
    opacity 0.1
    width calc(100vw - 20px)
    height 760px
    position absolute
    object-fit cover
    user-select none
  .hero-content
    margin 90px 2rem
    z-index 1
    max-width 960px
    h1.version
      position absolute
      font-size 30vh
      z-index -10000
      right 20vw
      user-select none
      opacity 0.5
    .white-logo
      width 240px
      height 80px
      img
        filter invert(1) grayscale(1) brightness(100) drop-shadow(0 0 10px #666)
    h1.hero
      animation 0.5s ease-out 0s 1 slideIn1
      color white
      font-family 'Open Sans', sans-serif
      font-weight 300
      font-size 60px
      text-shadow 0px 0px 10px #666
      // padding-top 10vh
    h2.lead
      animation 0.75s ease-out 0s 1 slideIn2
      color white
      border none
      font-family 'Open Sans', sans-serif
      font-weight normal
      font-size 1.125em
      text-shadow 0px 0px 10px #333
    .action-button
      animation 1s ease-out 0s 1 slideIn3
      margin-top 3rem
      display inline-block
      font-family 'Open Sans', sans-serif
      font-size 1rem
      color #fff
      background-color #ff3300dd
      padding 0.8rem 1.6rem
      border-radius 4px
      transition background-color .1s ease
      box-sizing border-box
      border 1px solid #fff
      &:hover
        background-color #fff
        color #ff3300
    .demo-button
      animation 1.25s ease-out 0s 1 slideIn3
      margin-top 3rem
      margin-left 0.5em
      display inline-block
      font-family 'Open Sans', sans-serif
      font-size 1rem
      color #fff
      padding 0.8rem 1.6rem
      border-radius 4px
      background-color #ffffff33
      transition background-color .1s ease
      box-sizing border-box
      border 1px solid #fff
      &:hover
        background-color #ffffff77
    @media (max-width 419px)
      h1.hero
        font-size 40px
    @media (min-width 720px)
      .action-button
        font-size 1.4rem
      .demo-button
        font-size 1.4rem
      
  .phone
    animation 2s ease-out 0s 1 slideIn3
    flex-shrink 0
    box-shadow 0px 0px 20px 10px rgba(0,0,0,0.2)
    width 375px + 10px
    height 640px; // 680px
    padding 5px
    border-radius 25px
    background #000
    align-self center
    margin-left 60px
    position relative
    margin-right 20px
    box-sizing border-box
    margin-top 60px

    .iframe-wrapper
      position relative
      border-radius inherit
      overflow hidden
      height 100%
      border-radius 20px
 
    iframe
      width 100%
      height 100%
      display block
      width 100%
      border-radius 20px
 
  .hero-image
    animation 2.5s ease-out 0s 1 fadeIn4
    background url(/hero3.jpg) bottom 0 left 50%/contain no-repeat
    background-repeat none 
    width 95%
    height 700px
    position absolute
    top calc(100% - 700px)
    opacity 0.5

  @media (max-width: 1023px)
    .phone
      display none
  @media (min-width: 1024px)
    .demo-button, .hero-image
      display none !important

</style>
