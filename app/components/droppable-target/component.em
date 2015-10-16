class DroppableTargetComponent extends Ember.Component

	model: null
	drop:'drop'
	nothingIsDragging: "nothingIsDragging"
	somethingIsDragging: null
	draggingModel: Ember.computed.alias 'somethingIsDragging.model'
	dragging: Ember.computed 'somethingIsDragging', -> @draggingModel is @model

	classNameBindings: ['dragging:dragging:not-dragging']

	didInsertElement: ->
		@_super()
		Ember.$(@element).droppable
			hoverClass: 'drop-hover'
			tolerance: 'pointer'
			drop: (event,ui) =>
				@sendAction 'drop',@model,ui.draggable.data('emberObject').model
				@sendAction 'nothingIsDragging'

`export default DroppableTargetComponent`