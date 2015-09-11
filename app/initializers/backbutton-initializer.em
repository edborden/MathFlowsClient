initializer =

	initialize: ->

		Ember.$(document).keydown (e) ->
			nodeName = e.target.nodeName.toLowerCase()

			if e.which is 8

				e.preventDefault() unless (nodeName is 'input' and e.target.type is 'text') or nodeName is 'textarea'

`export default initializer`