import { defineEventHandler } from 'h3'
import { getAllStats } from '../services/statsService'

export default defineEventHandler(async () => {
  return await getAllStats()
})
