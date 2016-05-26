router = require('../router')('home')
H = require('../helpers/shared')

router.get '/',
  H.proposals,
  H.inkpads,
  H.action('index'),
  H.render

module.exports = router;
