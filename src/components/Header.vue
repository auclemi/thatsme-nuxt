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
  <div id="header" class="sticky-top">
    <a href="#main-content" class="skip-link visually-hidden text-black">
      Vers contenu principal
    </a>

    <div class="container">
      <nav class="navbar navbar-expand header-background-color sticky-top">
        <div class="d-flex align-items-center">

          <!-- Logo -->
          <div aria-hidden="true">
            <NuxtLink to="/" class="navbar-image">
              <img
                src="/images/thatsME.png"
                alt="That's Me Logo"
                width="100"
              />
            </NuxtLink>
          </div>

          <!-- Titre + menu -->
          <div>
            <div class="text-white">
              <div class="brand title">
                <span aria-hidden="true">{{ props.title }}</span>
                <span class="visually-hidden">
                  DatsMi!, votre expert en développement web,
                </span>
              </div>
            </div>

            <ul class="navbar-nav">
              <li class="nav-item">
                <NuxtLink
                  class="nav-link text-white"
                  to="/"
                  :aria-current="isCurrent('/')"
                >
                  Accueil
                </NuxtLink>
              </li>

              <li class="nav-item">
                <NuxtLink
                  class="nav-link text-white"
                  to="/prestations-web"
                  :aria-current="isCurrent('/prestations-web')"
                >
                  Prestations Web
                </NuxtLink>
              </li>

              <li class="nav-item">
                <NuxtLink
                  class="nav-link text-white"
                  to="/contact"
                  :aria-current="isCurrent('/contact')"
                >
                  Contact
                </NuxtLink>
              </li>
            </ul>

          </div>
        </div>
      </nav>
    </div>
  </div>
</template>

<style scoped>
/* @import "~/components/header/header.scss"; */
</style>
