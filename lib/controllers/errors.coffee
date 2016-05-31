router = require('../router')('errors')

router.use (rq, rs, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

router.use (err, rq, rs, next) ->
  rs.status err.status or 500
  development = (require 'express')().get('env') is 'development'
  params =
    message: err.message
    error: ((development and err) or {status: err.status, message: err.message})
  rs.format
    json: ->
      rs.json params
    html: ->
      rs.render 'error', params

module.exports = router
