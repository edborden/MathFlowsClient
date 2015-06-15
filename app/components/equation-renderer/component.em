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
		@line.contentLength = @line.content.length
		beforeKeyDown = Ember.run.bind @,@testKeyDown
		@mathquill.on 'keydown',beforeKeyDown
		#console.log $._data @element,"events"
		@line.renderer = @		
		@focuser.focusLine @line if @line.isNew
		if @focuser.focusedLine is @line
			@focuser.focusElement @
		else
			Ember.$(@element).find('.cursor').remove()

	mathquill: null
	setMathQuillContent: ->
		@mathquill.mathquill('latex',@line.content)

	+observer block.question
	setQuestionElement: ->
		if @block.question
			@element.style.paddingLeft = @block.questionNumberWidth() + "px"
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

	newContent:null

	testKeyDown: (ev) -> 
		console.log ev
		ev.preventDefault()
		ev.stopPropagation()
		ev.stopImmediatePropagation()
		false

	beforeKeyDown: (ev) ->
		@cleanContent()
		@newContent = null
		keyCode = ev.keyCode
		codesToHandle = Ember.A [13,8]
		if codesToHandle.contains keyCode			
			@newContent = @keyboarder.setup(@line).keyDown(keyCode)			
		Ember.run.next @,@checkIfInsideEquation
		@line.contentLength = @line.content.length

	checkIfInsideEquation: ->
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
				@displayEquationEditorMenu = true
			else
				@displayEquationEditorMenu = false

	cleanContent: ->
		@line.content = if typeof @newContent is "string" then @newContent else @cleaner.latex @mathquill.mathquill 'latex'

	focusOut: -> 
		unless @line.isDeleted
			@displayEquationEditorMenu = false
			@cleanContent()
			@modeler.saveModel @line
			@setMathQuillContent() #unless @isDestroyed#this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

`export default EquationRendererComponent`