<script setup>
const route = useRoute()

// Define the order of your pages here
const pages = [
  { name: 'Accueil', path: '/' },
  { name: 'Prestations Web', path: '/prestations-web' },
  { name: 'Contact', path: '/contact' },
  { name: 'Accessibilité', path: '/accessibility' },
]

const currentIndex = computed(() => pages.findIndex(p => p.path === route.path))

const prevPage = computed(() => currentIndex.value > 0 ? pages[currentIndex.value - 1] : null)
const nextPage = computed(() => (currentIndex.value >= 0 && currentIndex.value < pages.length - 1) 
  ? pages[currentIndex.value + 1] 
  : null
)

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
  <div class="d-flex flex-column min-vh-100">
    <Header />

    <main id="main-content" class="container flex-grow-1 mt-4" tabindex="-1">
      <NuxtPage />

      <!-- Navigation Links -->
      <nav class="d-flex justify-content-between my-5" aria-label="Navigation par page">
        <div>
          <NuxtLink v-if="prevPage" :to="prevPage.path" class="btn btn-outline-success">
            &larr; {{ prevPage.name }}
          </NuxtLink>
        </div>
        <div>
          <NuxtLink v-if="nextPage" :to="nextPage.path" class="btn btn-outline-success">
            {{ nextPage.name }} &rarr;
          </NuxtLink>
        </div>
      </nav>
    </main>

    <Footer />
  </div>
</template>
