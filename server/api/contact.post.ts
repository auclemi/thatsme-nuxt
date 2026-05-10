import { defineEventHandler, readBody, createError, sendError } from 'h3'

export default defineEventHandler(async (event) => {
  const body = await readBody<{
    name?: string
    email?: string
    message?: string
  }>(event)

  const errors: Record<string, string> = {}

  if (!body.name || body.name.trim().length < 5)
    errors.name = 'Veuillez entrer votre nom.'

  if (!body.email || !body.email.match(/^[^@\s]+@[^@\s]+\.[^@\s]+$/))
    errors.email = 'Veuillez entrer un email valide.'

  if (!body.message || body.message.trim().length < 5)
    errors.message = 'Veuillez écrire un message.'

  if (Object.keys(errors).length > 0) {
    return sendError(
      event,
      createError({
        statusCode: 400,
        statusMessage: 'Validation error',
        data: { errors }
      })
    )
  }

  console.log('Message contact reçu :', body)

  return { ok: true }

})
