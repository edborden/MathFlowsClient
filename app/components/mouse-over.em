class MouseOverComponent extends Ember.Component
	model:null
	layoutName: 'components/mouse-over'
	mouseOver: false
	classNames: ['inline']
	isEditing:false
	showEdit: ~> not @isEditing and @mouseOver

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