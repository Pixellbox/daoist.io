main = (require 'express').Router()
H = require('./helpers/shared')

main.use (rq, rs, next) ->
  rs.locals.rootPath = -> '/'
  rs.locals.proposalsPath = -> '/proposals'
  rs.locals.newProposalPath = -> "#{rs.locals.proposalsPath()}/new"
  next()

module.exports = (name) ->
  router = (require 'express').Router()
  router.use main
  router.use H.controller(name) if name
  router
