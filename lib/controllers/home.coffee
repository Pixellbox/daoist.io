router = require('../router')('home')
H = require('../helpers/shared')
h = require('../helpers/home')

router.get '/',
  h.proposals,
  h.inkpads,
  h.link,
  H.action('index'),
  H.render

module.exports = router;
