exports.store = (rq, rs, next) ->
  rs.locals.proposal =
    modelName: 'proposal'
    get: -> ''
  rs.redirect '/'
