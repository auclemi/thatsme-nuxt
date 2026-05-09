<script setup>
import Header from '~/components/Header.vue'
import Footer from '~/components/Footer.vue'

useHead({
  link: [
    { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
    { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
  ],
  script: [
    { src: '/stats.js', defer: true }
  ],
  meta: [
    { charset: 'UTF-8' },
    { name: 'viewport', content: 'width=device-width' }
  ]
})
</script>

<template>
  <Header />

  <main id="main-content" class="container" tabindex="-1">
    <NuxtPage />
  </main>

  <Footer />
</template>
