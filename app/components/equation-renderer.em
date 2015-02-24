class EquationRendererComponent extends Ember.Component
	
	classNames: ['equation-renderer-container']

	position:null
	block: ~> @position.block

	mathquill: ~>
		Ember.$(@element).children().first().mathquill('textbox')

	didInsertElement: ->
		@setWidth()
		@mathquill.mathquill('latex',@block.content)
		Ember.$('.cursor').remove()
		@sendAction 'setEquationContainerHeight',Ember.$(@element).height()

	setWidth: ->
		thisJq = Ember.$(@element)
		parentWidth = @position.width
		pageNumberWidth = thisJq.parent().children().first().outerWidth()
		thisJq.width(parentWidth-pageNumberWidth)

	setEquationContainerHeight: 'setEquationContainerHeight'

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

	#checkIfHeightChanged: ->
	#	Ember.$(@element).outerHeight()

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