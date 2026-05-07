// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  srcDir: 'src/', 
  ssr: true,
  app: {
    baseURL: '/',
    buildAssetsDir: '/assets/'
  },
  css: [
    '~/styles/styles.scss',
    '~/layouts/layouts.scss'
  ]
})


