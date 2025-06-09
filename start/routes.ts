import router from '@adonisjs/core/services/router'
import { middleware } from './kernel.js'

const UrlsController = () => import('#controllers/urls_controller')
const AuthController = () => import('#controllers/auth_controller')

// 🏠 Accueil dynamique selon connexion
router.get('/', async ({ view, auth }) => {
  return view.render('pages/home', { auth })
})

// 🌐 Formulaire pour utilisateurs anonymes
router.get('/url/create', async ({ view }) => view.render('pages/anonymous_create'))

// ✅ Création URL (ouverte à tous : connectés et invités)
router.post('/shorten', [UrlsController, 'store'])

// 👤 Authentification
router.get('/login', async ({ view }) => view.render('pages/login'))
router.post('/login', [AuthController, 'login'])

router.get('/register', async ({ view }) => view.render('pages/register'))
router.post('/register', [AuthController, 'register'])

router.post('/logout', [AuthController, 'logout']).use(middleware.auth())

// 🧭 Pages utilisateurs connectés
router.get('/dash', [UrlsController, 'dash']).use(middleware.auth())
router.get('/about', async ({ view }) => view.render('pages/about')).use(middleware.auth())

// 📊 Stats (auth requis)
router.get('/stats', [UrlsController, 'stats']).use(middleware.auth())

// ✏️ Gestion des URLs (auth requis)
router.get('/urls/:id/edit', [UrlsController, 'edit']).use(middleware.auth())
router.post('/urls/:id', [UrlsController, 'update']).use(middleware.auth())
router.delete('/urls/:id', [UrlsController, 'destroy']).use(middleware.auth())

// 🔗 Redirection publique
router.get('/:shortCode', [UrlsController, 'redirect'])
