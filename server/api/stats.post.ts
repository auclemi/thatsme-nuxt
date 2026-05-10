import { addStat } from '../services/statsService'
import { defineEventHandler, readBody } from 'h3'


export default defineEventHandler(async (event) => {
  const body = await readBody(event)

  const blacklist = ['/stats']
  if (!blacklist.includes(body.path)) {
    await addStat({
      ...body,
      ts: Date.now()
    })
  }

  return { ok: true }
})
