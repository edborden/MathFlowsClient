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
	thisSomethingIsDragging: 'thisSomethingIsDragging'
	nothingIsDragging: 'nothingIsDragging'

	actions:
		drop: (object,options) ->
			@sendAction 'drop',object,options
		editObj: (obj) ->
			@sendAction 'editObj',obj
		copyObj: (obj) ->
			@sendAction 'copyObj',obj
		newObj: (containingFolder) ->
			@sendAction 'newObj',containingFolder
		thisSomethingIsDragging: (something) ->
			@sendAction 'thisSomethingIsDragging',something
		nothingIsDragging: -> @sendAction 'nothingIsDragging'
			
`export default TreeAccordianComponent`