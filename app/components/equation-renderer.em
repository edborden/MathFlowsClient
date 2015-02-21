class EquationRendererComponent extends Ember.Component

	block:null

	classNames: ['equation-renderer-container']

	layoutName: 'components/equation-renderer'

	mathquill: ~>
		Ember.$(@element).children().first().mathquill('textbox')

	didInsertElement: ->
		@setWidth()
		@mathquill.mathquill('latex',@block.content)
		Ember.$('.cursor').remove()

	setWidth: ->
		thisJq = Ember.$(@element)
		parentWidth = @position.width
		pageNumberWidth = thisJq.parent().children().first().outerWidth()
		thisJq.width(parentWidth-pageNumberWidth)

	actions:
		insertLatex: (latex) ->
			console.log latex
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	output: -> @mathquill.mathquill 'latex'

	click: -> @checkIfInsideEquation()

	keyDown: -> 
		@checkIfInsideEquation()
		true

	checkIfInsideEquation: ->
		if Ember.$('.hasCursor').hasClass('mathquill-rendered-math') or Ember.$('.hasCursor').parents('.mathquill-rendered-math').length isnt 0
			@displayEquationEditorMenu = true
		else
			@displayEquationEditorMenu = false

	focusOut: -> 
		@displayEquationEditorMenu = false
		unless @block.content is @output()
			@block.content = @output()
			@block.save()			
`export default EquationRendererComponent`