_ = require('lodash')
inkpad = require('node-inkpad')

NodeCache = require('node-cache')
$cache = new NodeCache()

ttl = 60 # seconds


# params: id1, id2, etc
#
module.exports = fn = ->
  ids = _.values(arguments)

  uncached = _.reject ids, (id) -> $cache.get id

  docs = Promise.all([])
  if uncached.length
    docs = inkpad.apply null, uncached

  docs.then (docs) ->
    _.each docs, (doc, id) ->
      console.log 'set', id
      $cache.set id, doc, ttl
  .then ->
    _.reduce ids, (h, id) ->
      h[id] = $cache.get id
      h
    , {}
