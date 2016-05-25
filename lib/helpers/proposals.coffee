_ = require('lodash')
Proposal = require('../models/proposal')
Checkit = require('checkit')

exports.proposalParams = ['title', 'name', 'email', 'url', 'outline']

exports.build = (rq, rs, next) ->
  params = _.pick(rq.body.proposal, exports.proposalParams)
  rs.locals.proposal = new Proposal params
  next()

exports.store = (rq, rs, next) ->
  proposal = rs.locals.proposal
  proposal
    .save()
    .then ->
      rs.redirect '/proposals/success'
    .catch Checkit.Error, (e) ->
      rs.locals.errors = _.reduce e.errors, (o, v, k) ->
        o[k] = v.message; o
      , {}
      next()
    .catch next
