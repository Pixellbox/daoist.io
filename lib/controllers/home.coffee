router = require('../router')('home')
H = require('../helpers/shared')
_ = require('lodash')

router.get '/',
  H.proposals,
  H.inkpads(true),
  H.action('index'),
  H.render

module.exports = router;
