_ = require('lodash')
inkpad = require('./inkpads')
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

exports.inkpad = (id) ->
  (rq, rs, next) ->
    id ||= rs.locals.inkpadId
    inkpad(id)
      .then (result) ->
        md = markdown(result[id] or '')
        (rs.locals.bodyClasses ||= []).push('has-team') if md.metadata.team
        rs.locals.inkpad = md
        next()
      .catch next
