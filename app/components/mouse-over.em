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
		editClicked: -> 
			@isEditing = true
			false
		saveClicked: ->
			@model.save() if @model.isDirty
			@isEditing = false
		deleteClicked: -> @model.destroyRecord()
			
`export default MouseOverComponent`