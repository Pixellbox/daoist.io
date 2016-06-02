main = (require 'express').Router()
H = require('./helpers/shared')
Proposal = require('./models/proposal')

main.use (rq, rs, next) ->
  rs.locals.rootPath = -> '/'
  rs.locals.safePath = -> '/safe'
  rs.locals.proposalsPath = -> '/proposals'
  rs.locals.newProposalPath = -> "#{rs.locals.proposalsPath()}/new"
  rs.locals.proposalSuccessPath = -> "#{rs.locals.proposalsPath()}/success"
  rs.locals.proposalPath = (proposal) -> "#{rs.locals.proposalsPath()}/#{proposal.get('slug')}"
  next()

slug = (rq, rs, next, value) ->
  if /^\w+$/.test(value)
    new Proposal
      slug: value
    .fetch()
    .then (proposal) ->
      if proposal
        rs.locals.proposal = proposal
        rs.locals.title = proposal.get('title')
        next()
      else
        next 'route'
    .catch next
  else
    next 'route'

module.exports = (name) ->
  router = (require 'express').Router()
  router.use main
  router.use H.controller(name) if name
  router.param 'slug', slug
  router
