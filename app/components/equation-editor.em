class EquationEditorComponent extends Ember.Component

	actions:
		saveEquation: -> @sendAction 'action',@output

	layoutName: 'components/equation-editor'

	didInsertElement: ->
		EqEditor.embed('toolbar',null,"mini")
		@output = new EqTextArea('equation', 'latexInput')		
		EqEditor.add(@output,false)
		EqEditor.setFormat('png')
			
`export default EquationEditorComponent`