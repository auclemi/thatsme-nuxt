import { promises as fs } from 'fs'
import path from 'path'

const filePath = path.join(process.cwd(), 'stats.json')

export async function getAllStats(reverse = true) {
  try {
    const raw = await fs.readFile(filePath, 'utf-8')
    const stats = JSON.parse(raw)
    if (!Array.isArray(stats)) return []
    return reverse ? stats.reverse() : stats
  } catch {
    return []
  }
}

export async function addStat(entry: any) {
  const all = await getAllStats()
  all.push(entry)
  await fs.writeFile(filePath, JSON.stringify(all, null, 2), 'utf-8')
}
