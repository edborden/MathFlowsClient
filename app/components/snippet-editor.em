class SnippetEditorComponent extends Ember.Component

	layoutName: 'components/snippet-editor'

	actions:
		savePressed: ->
			@sendAction 'saveButton',@snippet

		deletePressed: ->
			@sendAction 'destroyButton',@snippet

`export default SnippetEditorComponent`