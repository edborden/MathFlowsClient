class TreeAccordianComponent extends Ember.Component

	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	drop: 'drop'
	editObj: 'editObj'
	copyObj: 'copyObj'
	newObj: 'newObj'

	actions:
		drop: (object,options) ->
			@sendAction 'drop',object,options
		editObj: (obj) ->
			@sendAction 'editObj',obj
		copyObj: (obj) ->
			@sendAction 'copyObj',obj
		newObj: (containingFolder) ->
			@sendAction 'newObj',containingFolder

	dragging: ~> @model.isDraggingObject

	classNameBindings: ['dragging']
			
`export default TreeAccordianComponent`