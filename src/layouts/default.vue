<script setup lang="ts">
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
    // { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
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


function backToTop() {
  const scrollHandler = () => {
    const el = document.getElementById('main-content');
    // preventScroll ensures the focus doesn't trigger a browser-default scroll animation
    el?.focus({ preventScroll: true });
    // behavior: 'instant' ensures we jump to top without the sliding motion you dislike
    window.scrollTo({ top: 0, left: 0, behavior: 'instant' });
  };

  // Use the View Transition API to provide the fade effect defined in your SCSS
  if (document.startViewTransition) {
    document.startViewTransition(scrollHandler);
  } else {
    scrollHandler();
  }
}
</script>

<template>
  <div class="d-flex flex-column min-vh-100">
    <Header />

    <main id="main-content" name="main-content" class="container flex-grow-1 mt-4" tabindex="-1">
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
      <!-- At the bottom of your main content section -->
      <div class="text-end mt-3">
        <a href="#main-content" @click.prevent="backToTop" class="btn btn-link link-success">
          Haut de la page
        </a>
      </div>

    </main>

    <Footer />
  </div>
</template>
