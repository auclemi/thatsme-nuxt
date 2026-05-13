import { defineEventHandler, readBody, createError } from 'h3'
import nodemailer from 'nodemailer'

export default defineEventHandler(async (event) => {
  console.log("SMTP_HOST =", process.env.SMTP_HOST)
  const body = await readBody<{
    name?: string
    email?: string
    message?: string
  }>(event)

  const errors: Record<string, string> = {}

  if (!body.name || body.name.trim().length < 3)
    errors.name = 'Veuillez entrer votre nom.'

  if (!body.email || !body.email.match(/^[^@\s]+@[^@\s]+\.[^@\s]+$/))
    errors.email = 'Veuillez entrer un email valide.'

  if (!body.message || body.message.trim().length < 5)
    errors.message = 'Veuillez écrire un message.'

  if (Object.keys(errors).length > 0) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Validation error',
      data: { errors }
    })
  }



  // --- CONFIG SMTP ---
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT ?? 587),
    secure: false,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS
    }
  })

  // --- ENVOI DU MAIL ---
  const info = await transporter.sendMail({
    from: process.env.CONTACT_FROM,
    to: process.env.CONTACT_TO,
    subject: `📬 Nouveau message de ${body.name} (${process.env.ENVIRONMENT})`,
    replyTo: body.email,
    text: `
Nom : ${body.name}
Email : ${body.email}

Message :
${body.message}
    `.trim()
  })

  console.log('📧 Mail envoyé via Nuxt :', info.messageId)

  return { ok: true }
})