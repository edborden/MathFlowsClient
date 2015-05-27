class TreeOverComponent extends Ember.Component
	model:null
	mouseOver: false
	isEditing:false
	showMenu: ~> not @isEditing and @mouseOver

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	focusOut: ->
		@model.save() if @model.isDirty
		@isEditing = false

	editDoc: 'editDoc'
	copyDoc: 'copyDoc'
	newFlow: 'newFlow'
	newStudent: 'newStudent'

	actions:
		toggle: -> 
			@model.toggleProperty('open')
			@model.save()
		nameClicked: -> 
			@isEditing = true
			Ember.run.next @, => Ember.$(".name-editor").focus()
			false
		editDoc: -> 
			@sendAction 'editDoc', @model
		copyClicked: ->
			@sendAction 'copyDoc',@model
		newFlow: (folder) ->
			@sendAction 'newFlow',folder
		newStudent: (folder) ->
			@sendAction 'newStudent',folder
			
`export default TreeOverComponent`