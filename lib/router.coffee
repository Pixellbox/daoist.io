main = (require 'express').Router()
H = require('./helpers/shared')

module.exports = (name) ->
  router = (require 'express').Router()
  router.use main
  router.use H.controller(name) if name
  router
