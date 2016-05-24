router = require('../router')('proposals')
H = require('../helpers/shared')
h = require('../helpers/proposals')

router.get '/proposals/new',
  H.action('new'),
  H.render

router.post '/proposals',
  h.store,
  H.action('new')
  H.render

module.exports = router;
