<script setup>
import { useRoute } from 'vue-router'

// Déclaration des props (équivalent Astro.props)
const props = defineProps({
  title: {
    type: String,
    default: "That's Me !"
  }
})

// Route active pour aria-current
const route = useRoute()
const isCurrent = (path) => (route.path === path ? "page" : undefined)
</script>
<template>
<div class="row g-0 mt-5" id="footer">
  <div
    class="col-12 col-md-6 d-flex flex-wrap justify-content-md-end text-break gx-3"
    style="min-width:0;"
  >
    <div class="title">
      <span aria-hidden="true">That's Me !</span>
      <span class="visually-hidden">
          DatsMi!, votre expert en développement web,
      </span>
      | <small>Mis à jour 15-05-2026</small>
    </div>
  </div>

  <div
    class="col-12 col-md-4 d-flex justify-content-md-start gx-3"
    style="min-width:0;"
  >
    <nav>
      <NuxtLink to="/accessibility" class="nav-link" :aria-current="isCurrent('/accessibility')">Déclaration d'accessibilité</NuxtLink>
    </nav>
  </div>
</div>

</template>