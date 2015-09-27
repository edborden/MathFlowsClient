`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class NameEditorComponent extends Ember.Component

	tagName: 'span'

	size:14
	model:null
	isEditingName:null
	handleNameClick: true

	action: 'doneEditingName'
	nameClicked: 'nameClicked'

	onIsEditingNameChange: (->
		Ember.run.next @, =>
			Ember.$(@element).children().first().focus() if @isEditingName
	).observes 'isEditingName'

	focusOut: ->
		saveModel @model
		@sendAction()

	actions:
		nameClicked: -> 
			@sendAction 'nameClicked' if @handleNameClick

`export default NameEditorComponent`