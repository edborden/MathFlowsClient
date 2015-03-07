class TreeAccordianComponent extends Ember.Component

	expanded: ~> @model.open
	iconName:null
	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	actions:
		toggle: -> 
			@model.toggleProperty('open')
			@model.save()
			
`export default TreeAccordianComponent`