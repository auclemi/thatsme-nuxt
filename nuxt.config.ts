import { defineNuxtConfig } from 'nuxt/config'
export default defineNuxtConfig({
  runtimeConfig: {
    public: {
      apiUrl: process.env.NUXT_PUBLIC_API_URL || '/api'
    }
  },
  srcDir: 'src/',
  ssr: true,
  devServer: {
    port: 3100
  },
  app: {
    baseURL: '/',
  },

  experimental: {
    viewTransition: true
  },

  css: [
    'bootstrap/dist/css/bootstrap.min.css',
    '~/styles/styles.scss',
    '~/layouts/layouts.scss'
  ]
})
