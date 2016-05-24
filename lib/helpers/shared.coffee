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

exports.render = (rq, rs) ->
  defaultClasses = _.filter [rs.locals.controllerName, rs.locals.actionName], (c) -> !!c
  rs.locals.bodyClasses = _.union(defaultClasses, rs.locals.bodyClasses or [])
  rs.render "#{rs.locals.controllerName}/#{rs.locals.actionName}"

exports.inkpads = (short) ->
  (rq, rs, next) ->
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
          md = result[v.inkpad]
          md = if short then md.split(/\$intro/)[0] else md.replace(/\$intro/g, '')
          o[k] = markdown(md)
          o
        , {}
        next()
      .catch next

exports.proposals = (rq, rs, next) ->
  rs.locals.proposals = require('../proposals');
  next()
