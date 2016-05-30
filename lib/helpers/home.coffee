Proposal = require('../models/proposal')
Promise = require('bluebird')
config = require('../config')
inkpad = require('node-inkpad')
markdown = require('inkpad-markdown')
_ = require('lodash')

exports.proposals = (rq, rs, next) ->
  Proposal
    .query('whereNotNull', 'slug')
    .fetchAll()
    .then (result) ->
      rs.locals.proposals = result.models
      next()
    .catch next

exports.inkpads = (rq, rs, next) ->
  proposals = rs.locals.proposals
  ids = [config.homepage.inkpad].concat(_.map proposals, (p) -> p.get('inkpad'))

  inkpad
    .apply(null, ids)
    .then (inkpads) ->
      rs.locals.inkpads = inkpads
      next()
    .catch next

exports.link = (rq, rs, next) ->
  [proposals, inkpads] = _.at rs.locals, ['proposals', 'inkpads']
  rs.locals.homepageInkpad = markdown(inkpads[config.homepage.inkpad] or '')
  _.each proposals, (proposal) ->
    proposal.inkpad = markdown(inkpads[proposal.get('inkpad')] or '')
  next()