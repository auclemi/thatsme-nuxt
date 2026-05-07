<script setup>
import Header from '~/components/Header.vue'
import Footer from '~/components/Footer.vue'
import { computed } from 'vue'

const props = defineProps({
  title: { type: String, default: '' },
  titleSuffix: { type: String, default: " - That's Me !" }
})

const documentTitle = computed(() =>
  props.title && !props.title.endsWith(props.titleSuffix)
    ? props.title + props.titleSuffix
    : props.title
)

useHead({
  title: documentTitle.value,
  link: [
    { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
    { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
  ],
  script: [
    { src: '/stats.js', defer: true },
    {
      src: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js',
      integrity: 'sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe',
      crossorigin: 'anonymous'
    }
  ],
  meta: [
    { charset: 'UTF-8' },
    { name: 'viewport', content: 'width=device-width' }
  ]
})
</script>

<template>
  <div class="d-flex flex-column min-vh-100">
    <Header :title="props.title" />

    <div id="main-content" tabindex="-1" class="container mt-3 flex-grow-1">
      <NuxtPage />
    </div>

    <Footer />
  </div>
</template>

<style>
@import "~/styles/styles.scss";
@import "~/layouts/layouts.scss";
</style>
