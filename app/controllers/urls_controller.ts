import type { HttpContext } from '@adonisjs/core/http'
import Url from '#models/url'
import Click from '#models/click'
import { nanoid } from 'nanoid'
import { DateTime } from 'luxon'

export default class UrlsController {
  public async store({ request, auth, view }: HttpContext) {
    const data = request.only(['original_url', 'expires_at'])
    const shortCode = request.input('custom_alias') || nanoid(6)

    const isGuest = !auth.user

    try {
      const url = await Url.create({
        originalUrl: data.original_url,
        shortCode,
        expiresAt: data.expires_at ? DateTime.fromISO(data.expires_at) : null,
        userId: auth.user?.id ?? null,
        maxClicks: isGuest ? 5 : null, // ⬅️ limite pour les anonymes
      })

      const fullShortUrl = `http://localhost:3333/${url.shortCode}`
      console.log('FULL SHORT URL:', fullShortUrl)
      return view.render('pages/confirmation', { shortUrl: fullShortUrl, isGuest })
    } catch (error) {
      console.error(error)
      return view.render('pages/confirmation', { error: 'Failed to create URL' })
    }
  }

  public async dash({ auth, view }: HttpContext) {
    const user = auth.user!
    const urls = await Url.query().where('user_id', user.id)

    // Charger les clics pour chaque URL, groupés par date
    const clicksByUrl = await Promise.all(
      urls.map(async (url) => {
        const clicks = await Click.query().where('url_id', url.id).orderBy('clicked_at', 'asc')

        const grouped = clicks.reduce(
          (acc, click) => {
            const date = click.clickedAt.toFormat('yyyy-LL-dd')
            acc[date] = (acc[date] || 0) + 1
            return acc
          },
          {} as Record<string, number>
        )

        return {
          shortCode: url.shortCode,
          data: grouped,
        }
      })
    )
    return view.render('pages/dash', { clicksByUrl })
  }

  public async redirect({ params, response, request, view }: HttpContext) {
    const url = await Url.findBy('shortCode', params.shortCode)
    if (!url) return response.status(404).send('Not found')

    if (url.expiresAt && url.expiresAt < DateTime.now()) {
      return response.status(410).send('Link expired')
    }

    // ✅ Vérifie si clics max atteints
    if (typeof url.maxClicks === 'number') {
      const countResult = await Click.query().where('url_id', url.id).count('* as total').first()
      const clickCount = Number(countResult?.$extras.total ?? 0)

      if (clickCount >= url.maxClicks) {
        return view.render('pages/expired')
      }
    }

    // Enregistre le clic
    await Click.create({
      urlId: url.id,
      ipAddress: request.ip(),
      userAgent: request.header('user-agent'),
      clickedAt: DateTime.now(),
      description: 'Clicked from redirect endpoint',
    })
    return response.redirect(url.originalUrl)
  }

  public async edit({ params, view }: HttpContext) {
    const url = await Url.findOrFail(params.id)
    return view.render('pages/edit', { url })
  }

  public async update({ params, request, response }: HttpContext) {
    const url = await Url.findOrFail(params.id)
    url.originalUrl = request.input('original_url')
    url.expiresAt = request.input('expires_at')
      ? DateTime.fromISO(request.input('expires_at'))
      : null
    await url.save()
    return response.redirect('/stats')
  }

  public async destroy({ params, response }: HttpContext) {
    const url = await Url.findOrFail(params.id)
    await url.delete()
    return response.redirect('/stats')
  }

  public async stats({ auth, view }: HttpContext) {
    console.log('AUTH USER:', auth.user)
    const urls = await Url.query()
      .where('user_id', auth.user!.id)
      .withCount('clicks')
      .preload('clicks', (query) => {
        query.orderBy('clicked_at', 'desc').limit(1)
      })

    const result = urls.map((url) => {
      const lastClick = url.clicks[0]

      return {
        id: url.id,
        shortCode: url.shortCode,
        clicks: url.$extras.clicks_count ?? 0,
        lastClickedAt: lastClick?.clickedAt?.toFormat('yyyy-LL-dd HH:mm') || null,
        lastIp: lastClick?.ipAddress || 'N/A',
        lastLocation: lastClick?.description || 'N/A',
      }
    })
    console.log('RESULT FINAL:', result)
    return view.render('pages/stats', { urls: result })
  }
}
