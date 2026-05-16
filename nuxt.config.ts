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
    // head: {
    //   charset: 'utf-8',
    //   viewport: 'width=device-width, initial-scale=1',
    //   link: [
    //     { rel: 'icon', type: 'image/png', href: '/favicon-96x96.png', sizes: '96x96' },
    //     { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
    //     { rel: 'shortcut icon', href: '/favicon.ico' },
    //     { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' },
    //     { rel: 'manifest', href: '/site.webmanifest' }
    //   ]
    // }
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
