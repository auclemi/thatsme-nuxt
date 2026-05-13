import { defineEventHandler, handleCors } from 'h3'
export default defineEventHandler((event) => {
  // handleCors is a built-in utility in Nitro/h3
  handleCors(event, {
    origin: ['https://thatsme.freeboxos.fr', 'http://localhost:3000', 'http://localhost:3100'],
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
    preflight: {
      statusCode: 204,
    },
  })
})
