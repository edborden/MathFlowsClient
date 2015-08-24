class NameEditorComponent extends Ember.Component

	tagName: 'span'

	modeler:Ember.inject.service()

	size:14
	model:null
	isEditingName:null
	handleNameClick: true

	action: 'doneEditingName'
	nameClicked: 'nameClicked'

	+observer isEditingName
	onIsEditingNameChange: ->
		Ember.run.next @, =>
			Ember.$(@element).children().first().focus() if @isEditingName

	focusOut: ->
		@modeler.saveModel @model
		@sendAction()

	actions:
		nameClicked: -> 
			@sendAction 'nameClicked' if @handleNameClick

`export default NameEditorComponent`