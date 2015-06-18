class EquationRendererComponent extends Ember.Component

	cleaner: Ember.inject.service()
	store:Ember.inject.service()
	focuser:Ember.inject.service()
	keyboarder: Ember.inject.service()
	modeler:Ember.inject.service()

	line:null
	block: Ember.computed.alias 'line.block'
	
	didInsertElement: ->
		@setQuestionElement()
		@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		@setMathQuillContent()
		@setKeyDownHandler()
		@line.renderer = @		
		@focuser.setFocusLine(@line,'start') if @line.isNew
		if @focuser.focusedLine is @line
			@focuser.focusLine()
		else
			Ember.$(@element).find('.cursor').remove()

	setMathQuillContent: ->
		@mathquill.mathquill('latex',@line.content)

	setKeyDownHandler: ->
		#set handler
		onKeyDown = Ember.run.bind @,@onKeyDown
		@mathquill.on 'keydown',onKeyDown

		#reorder handlers for ember to run before mathquill
		handlers = jQuery._data( @mathquill[0], "events" ).keydown
		handler = handlers.pop()
		handlers.splice(0, 0, handler)

	+observer block.question
	setQuestionElement: ->
		@element.style.paddingLeft = if @block.question
			@block.questionNumberWidth() + "px"
		else
			@element.style.paddingLeft = 0

	actions:
		insertLatex: (latex) ->
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	click: -> 
		@checkIfInsideEquation()
		true

	dontFocusOut: false
	onKeyDown: (ev) ->
		@dontFocusOut = false
		Ember.run.later @,@checkIfInsideEquation
		keyCode = ev.keyCode
		codesToHandle = Ember.A [13,8,37,38,39,40,46]
		if codesToHandle.contains keyCode
			@cleanContent()
			@dontFocusOut = @keyboarder.setup(@line).keyDown(keyCode)
			console.log 'dontFocusOut =',@dontFocusOut

	checkIfInsideEquation: ->
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			@displayEquationEditorMenu = cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0

	cleanContent: ->
		@line.content = @cleaner.latex @mathquill.mathquill 'latex'

	focusOut: -> 
		unless @dontFocusOut
			@displayEquationEditorMenu = false
			@cleanContent()
			@modeler.saveModel @line
			@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

`export default EquationRendererComponent`