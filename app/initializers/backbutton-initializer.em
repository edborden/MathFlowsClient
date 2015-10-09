initializer =

  initialize: ->

    Ember.$(document).keydown (e) ->
      if e.which is 8
        nodeName = e.target.nodeName.toLowerCase()
        e.preventDefault() unless nodeName is 'input' or nodeName is 'textarea'

`export default initializer`