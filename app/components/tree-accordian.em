class TreeAccordianComponent extends Ember.Component

	expanded: ~> @model.open
	iconName:null
	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	drop: 'drop'

	actions:
		toggle: -> 
			@model.toggleProperty('open')
			@model.save()
		drop: (object,options) ->
			@sendAction 'drop',object,options

	dragging: ~> @model.isDraggingObject

	classNameBindings: ['dragging']
			
`export default TreeAccordianComponent`