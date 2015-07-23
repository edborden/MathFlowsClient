`import ElRegister from 'math-flows-client/mixins/el-register'`

class TreeOverComponent extends Ember.Component with ElRegister
	model:null
	mouseOver: false
	isEditing:false
	showMenu: ~> not @isEditing and @mouseOver and not @dragging and not @somethingIsDragging
	dragging: false
	somethingIsDragging: null # from Controller
	thisSomethingIsDragging: 'thisSomethingIsDragging'
	nothingIsDragging: 'nothingIsDragging'

	didInsertElement: ->
		@_super()
		@makeDraggable()

	makeDraggable: ->
		Ember.$(@element).draggable
			revert: true 
			start: =>
				@dragging = true
				@sendAction 'thisSomethingIsDragging',@
			stop: =>
				unless @isDestroyed
					@dragging = false
					@sendAction 'nothingIsDragging'
					@makeDraggable() #must re-initialize, otherwise can only drag once

	destroyDraggable: ->
		Ember.$(@element).draggable 'destroy'		

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	focusOut: ->
		@makeDraggable()
		@model.save() if @model.isDirty
		@isEditing = false

	actions:
		toggle: -> 
			@model.toggleProperty 'open'
			@model.save()
		nameClicked: ->
			@destroyDraggable()
			@isEditing = true
			Ember.run.next @, => Ember.$(".name-editor").focus()
			false
			
`export default TreeOverComponent`