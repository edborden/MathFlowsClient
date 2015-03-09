class MouseOverComponent extends Ember.Component
	model:null
	mouseOver: false
	classNames: ['inline']
	isEditing:false
	showEdit: ~> not @isEditing and @mouseOver
	layoutName: 'components/mouse-over'

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	actions:
		nameClicked: -> 
			@isEditing = true
			Ember.run.next @, => Ember.$(@element).children().first().focus()
			false

	focusOut: ->
		@model.save() if @model.isDirty
		@isEditing = false
			
`export default MouseOverComponent`