router = require('../router')('home')
H = require('../helpers/shared')

router.get '/',
  H.action('index'),
  H.render

module.exports = router;
