router = require('../router')('pages')
H = require('../helpers/shared')

router.get '/safe',
  H.inkpad(process.env.SAFE_INKPAD_ID),
  H.action('show'),
  H.render

module.exports = router
