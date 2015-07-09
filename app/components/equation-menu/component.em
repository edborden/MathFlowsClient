class EquationMenuComponent extends Ember.Component

	mathquill: null
	topOffset: null

	actions:
		insertLatex: (latex) ->
			#Ember.$(@element).focus()
			#@displayEquationEditorMenu = true
			@mathquill.mathquill 'cmd',latex

	attributeBindings: ['style']

	style: ~> "top:#{@topOffset*1.25}px".htmlSafe() #when the mathquill element height is the same as the block.linesHeight, this 1.25 fudger won't be necessary

`export default EquationMenuComponent`