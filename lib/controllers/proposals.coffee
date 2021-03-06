router = require('../router')('proposals')
H = require('../helpers/shared')
h = require('../helpers/proposals')

router.get '/proposals/new',
  h.build,
  H.action('new'),
  H.render

router.get '/proposals/success',
  H.action('success'),
  H.render

router.post '/proposals',
  h.build,
  h.store,
  # Handle failure…
  H.status(422),
  H.action('new')
  H.render

router.get '/proposals/:slug',
  h.inkpad,
  H.inkpad(),
  H.action('show')
  H.render

module.exports = router;
