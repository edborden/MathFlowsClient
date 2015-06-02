class DroppableTargetComponent extends Ember.Component

	drop:'drop'
	nothingIsDragging: "nothingIsDragging"

	didInsertElement: ->
		@_super()
		Ember.$(@element).droppable
			tolerance: 'pointer'
			drop: (event,ui) =>
				@sendAction 'drop',@model,ui.draggable.data('emberObject').model
				@sendAction 'nothingIsDragging'

`export default DroppableTargetComponent`