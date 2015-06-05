class EquationRendererComponent extends Ember.Component

	cleaner: Ember.inject.service()
	
	didInsertElement: ->
		@setWidth()
		@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		@setMathQuillContent()
		@sendAction 'setEquationContainerHeight',Ember.$(@element).height()

	mathquill: null
	setMathQuillContent: ->
		@mathquill.mathquill('latex',@block.content)
		Ember.$('.cursor').remove()

	+observer block.width
	setWidth: ->
		width = @block.width - @block.questionNumberWidth()
		Ember.$(@element).width(width)

	setEquationContainerHeight: 'setEquationContainerHeight'
	saveModel: 'saveModel'

	actions:
		insertLatex: (latex) ->
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	click: -> @checkIfInsideEquation()

	keyDown: -> 
		Ember.run.next @,@checkIfInsideEquation
		true

	#checkIfHeightChanged: ->
	#	Ember.$(@element).outerHeight()

	checkIfInsideEquation: ->
		cursorElement = Ember.$('.hasCursor')
		if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
			@displayEquationEditorMenu = true
		else
			@displayEquationEditorMenu = false

	focusOut: -> 
		@displayEquationEditorMenu = false
		@block.content = @cleaner.latex @mathquill.mathquill 'latex'
		@sendAction 'saveModel',@block
		@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

`export default EquationRendererComponent`