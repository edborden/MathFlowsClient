`import HandlesDragging from 'math-flows-client/mixins/handles-dragging'`
`import ElRegister from 'math-flows-client/mixins/el-register'`
`import TreeObjects from 'math-flows-client/mixins/tree-objects'`

class TreeOverComponent extends Ember.Component with HandlesDragging,ElRegister,TreeObjects
	model:null
	static:null
	mouseOver: false
	isEditing:false
	showMenu: ~> not @isEditing and @mouseOver and not @dragging and not @somethingIsDragging
	dragging: false
	activeObj:null
	active: ~> @activeObj is @model
	nameClicked:null

	classNameBindings: ['static','active']

	didInsertElement: ->
		@_super()
		@makeDraggable() unless @static

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
			@model.save() if @model.isFolder and not @static
		sendEditObj: ->
			@sendAction 'editObj',@model,@static
		nameClicked: ->
			@send @nameClicked
		editName: ->
			unless @static
				@destroyDraggable()
				@isEditing = true
				Ember.run.next @, => Ember.$(".name-editor").focus()
				false			
`export default TreeOverComponent`