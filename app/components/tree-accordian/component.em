class TreeAccordianComponent extends Ember.Component

	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	drop: 'drop'
	editDocument: 'editDocument'
	copyDocument: 'copyDocument'
	newFlow: 'newFlow'
	newStudent: 'newStudent'

	actions:
		drop: (object,options) ->
			@sendAction 'drop',object,options
		editDocument: (document) ->
			@sendAction 'editDocument',document
		copyDocument: (document) ->
			@sendAction 'copyDocument',document
		newFlow: (folder) ->
			@sendAction 'newFlow',folder
		newStudent: (folder) ->
			@sendAction 'newStudent',folder

	dragging: ~> @model.isDraggingObject

	classNameBindings: ['dragging']
			
`export default TreeAccordianComponent`