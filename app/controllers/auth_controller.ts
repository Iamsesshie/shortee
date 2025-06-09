// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from '#models/user'
import { HttpContext } from '@adonisjs/core/http'
import hash from '@adonisjs/core/services/hash'

export default class AuthController {
  public async register({ request, response, auth, session }: HttpContext) {
    const { email, password, fullName } = request.only(['email', 'password', 'fullName'])

    try {
      const user = new User()
      user.email = email
      user.password = password
      user.fullName = fullName
      await user.save()

      await auth.use('web').login(user)
      return response.redirect('/dash')
    } catch (error) {
      console.error(error)
      session.flash('errors', {
        email: 'Registration failed. Please try again.',
      })
      return response.redirect('/register')
    }
  }
  public async login({ request, response, auth, session }: HttpContext) {
    const { email, password } = request.only(['email', 'password'])

    // Rechercher l'utilisateur
    const user = await User.findBy('email', email)

    if (!user) {
      session.flash('errors', { email: 'User not found' })
      return response.redirect('/login')
    }

    // Vérifier le mot de passe
    const isPasswordValid = await hash.verify(user.password, password)

    if (!isPasswordValid) {
      session.flash('errors', { email: 'Invalid password' })
      return response.redirect('/login')
    }

    // Connecter l'utilisateur
    await auth.use('web').login(user)
    return response.redirect('/dash')
  }

  public async logout({ auth, response }: HttpContext) {
    await auth.use('web').logout()
    return response.redirect('/login')
  }
}
