import { getAllStats } from '../services/statsService'
import { defineEventHandler } from 'h3'
export default defineEventHandler(async (event) => {
  const data = await getAllStats()

  const html = `
    <h1>Stats simples</h1>
    <p>Visites totales : ${data.length}</p>
    <p>Visiteurs uniques : ${new Set(data.map(d => d.uid)).size}</p>

    <h2>Détails</h2>
    <ul>
      ${data
        .map(
          d =>
            `<li>${new Date(d.ts).toLocaleString()} — ${d.path} — ${d.uid}</li>`
        )
        .join('')}
    </ul>
  `

  event.node.res.setHeader('Content-Type', 'text/html; charset=utf-8')
  return html
})
