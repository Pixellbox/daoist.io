_ = require('lodash')
inkpad = require('node-inkpad')
markdown = require('inkpad-markdown')

exports.action = (actionName) ->
  (rq, rs, next) ->
    rs.locals.actionName = actionName
    next()

exports.title = (value) ->
  (rq, rs, next) ->
    rs.locals.title = value
    next()

exports.controller = (controllerName) ->
  (rq, rs, next) ->
    rs.locals.controllerName = controllerName
    next()

exports.addBodyClass = ->
  classes = [].slice.call(arguments)
  (rq, rs, next) ->
    rs.locals.bodyClasses = _.union(rs.locals.bodyClasses or [], classes)
    next()

exports.status = (code) ->
  (rq, rs, next) ->
    rs.status code
    next()

exports.render = (rq, rs) ->
  defaultClasses = _.filter [rs.locals.controllerName, rs.locals.actionName], (c) -> !!c
  rs.locals.bodyClasses = _.union(defaultClasses, rs.locals.bodyClasses or [])
  rs.render "#{rs.locals.controllerName}/#{rs.locals.actionName}"

exports.extractParams = (md) ->
  rgx = /\s*@param.+$/mg
  matches = md.match(rgx)
  params = _.reduce matches, (o, match) ->
    parts = match.split /\s*;\s*/
    key = parts[0].replace(/^\s*@param\s+|\s*$/, '')
    o[key] ||= []
    o[key].push(parts.slice 1)
    o
  , {}
  params.toString = -> md.replace(rgx, '')
  params

exports.inkpads = (rq, rs, next) ->
  proposals = rs.locals.proposals
  ids = _
    .chain(proposals)
    .values()
    .map (p) -> p.inkpad
    .value()

  inkpad
    .apply(null, ids)
    .then (result) ->
      rs.locals.inkpads = _.reduce proposals, (o, v, k) ->
        parsed = exports.extractParams(result[v.inkpad])
        o["#{k}_params"] = parsed
        o[k] = markdown(parsed.toString()); o
      , {}
      next()
    .catch next

exports.proposals = (rq, rs, next) ->
  rs.locals.proposals = require('../proposals');
  next()
