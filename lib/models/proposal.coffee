Bookshelf = require('../bookshelf')
Checkit = require('checkit')

class Proposal extends Bookshelf.Model
  tableName: 'proposals'
  modelName: 'Proposal'
  hasTimestamps: true

  validations:
    title: ['required']
    name: ['required']
    email: ['required']
    url: []
    outline: ['required']

  initialize: ->
    @on 'saving', @validate

  validate: =>
    Checkit(@validations).run @toJSON()

module.exports = Proposal
