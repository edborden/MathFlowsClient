class EquationRendererComponent extends Ember.Component

	##SETUP

	cleaner: Ember.inject.service()
	store:Ember.inject.service()
	focuser:Ember.inject.service()
	keyboarder: Ember.inject.service()
	modeler:Ember.inject.service()

	line:null
	preview:null
	block: Ember.computed.alias 'line.block'
	questionNumberWidth: Ember.computed.alias 'block.questionNumberWidth'

	attributeBindings: ['style']
	style: ~> "padding-left:#{@questionNumberWidth}px".htmlSafe()

	##EVENTS

	didInitAttrs: ->
		@line.renderer = @		
	
	didInsertElement: ->
		if @preview
			@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		else
			@mathquill = Ember.$(@element).children().last().mathquill('textbox')
			@setMathQuillContent()
			@setKeyDownHandler()
			Ember.$(@element).find('.cursor').remove()

	onKeyDown: (ev) ->
		unless @preview
			@keyboarder.process @line,ev.keyCode,@mathquill	
			Ember.run.next @,@checkIfInsideEquation
			true

	focusOut: -> 
		console.log 'focusOut'
		unless @preview
			@removeEquationEditorMenu()
			@cleaner.clean @line,@mathquill
			@modeler.saveModel @line
			#@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

	click: -> 
		@checkIfInsideEquation() unless @preview
		@sendAction()
		false

	+observer line.content
	contentChanged: -> 
		@setMathQuillContent()
		Ember.$(@element).find('.cursor').remove()

	willDestroyElement: -> @removeKeyDownHandler()

	##HELPERS

	setMathQuillContent: -> @mathquill.mathquill 'latex',@line.content

	setKeyDownHandler: ->
		#set handler
		onKeyDown = Ember.run.bind @,@onKeyDown
		@mathquill.on 'keydown',onKeyDown

		#reorder handlers for ember to run before mathquill
		handlers = jQuery._data( @mathquill[0], "events" ).keydown
		handler = handlers.pop()
		handlers.splice(0, 0, handler)

	removeKeyDownHandler: ->
		@mathquill.off 'keydown',@onKeyDown

	checkIfInsideEquation: ->
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
				@displayEquationEditorMenu() 
			else
				@removeEquationEditorMenu()

	displayEquationEditorMenu: ->
		@sendAction 'activeEquationLine',@mathquill

	removeEquationEditorMenu: ->
		@sendAction 'inactiveEquationLine',@mathquill

	##ACTIONS

	#actions:
	#	insertLatex: (latex) ->
	#		Ember.$(@element).focus()
	#		@displayEquationEditorMenu = true
	#		@mathquill.mathquill 'cmd',latex

	action: 'contentsClicked'
	activeEquationLine: 'activeEquationLine'
	inactiveEquationLine: 'inactiveEquationLine'

`export default EquationRendererComponent`