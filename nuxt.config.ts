export default defineNuxtConfig({
  srcDir: 'src/',
  ssr: true,

  dir: {
    public: 'src/public'
  },

  app: {
    baseURL: '/',
    buildAssetsDir: '/assets/'
  },

  css: [
    'bootstrap/dist/css/bootstrap.min.css',
    '~/styles/styles.scss',
    '~/layouts/layouts.scss'
  ]
})
