class SnippetEditorComponent extends Ember.Component

	layoutName: 'components/snippet-editor'

	actions:
		save: ->
			@sendAction 'saveButton',@snippet

		destroy: ->
			@sendAction 'destroyButton',@snippet

`export default SnippetEditorComponent`