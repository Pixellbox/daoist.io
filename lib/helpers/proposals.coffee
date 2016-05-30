_ = require('lodash')
Proposal = require('../models/proposal')
Checkit = require('checkit')
inkpad = require('node-inkpad')
markdown = require('inkpad-markdown')
H = require('./shared')

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

exports.inkpad = (rq, rs, next) ->
  proposal = rs.locals.proposal
  id = proposal.get('inkpad')

  inkpad(id)
    .then (result) ->
      rs.locals.inkpad = markdown(result[id] or '')
      next()
    .catch next
