`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

class EquationRendererComponent extends Ember.Component with HandlesEquations

	##SETUP

	cleaner: Ember.inject.service()
	store:Ember.inject.service()
	focuser:Ember.inject.service()
	keyboarder: Ember.inject.service()
	modeler:Ember.inject.service()

	line:null
	preview:null
	insideEquation: null
	questionNumberWidth: Ember.computed.alias 'line.block.questionNumberWidth'

	attributeBindings: ['style']
	style: ~> "padding-left:#{@questionNumberWidth}px".htmlSafe()

	##EVENTS

	didInitAttrs: ->
		@line.renderer = @ if @line.isLine
	
	didInsertElement: ->
		@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		@setMathQuillContent()
		@setKeyDownHandler()
		Ember.$(@element).find('.cursor').remove()

	onKeyDown: (ev) ->
		unless @preview
			@keyboarder.process @line,ev.keyCode,@mathquill	if @line.isLine
			Ember.run.next @,@checkIfInsideEquation
			true

	focusOut: -> 
		console.log 'focusOut'
		unless @preview
			@insideEquation = false
			@cleaner.clean @line,@mathquill
			@modeler.saveModel @line
			#@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

	click: -> 
		@checkIfInsideEquation() unless @preview
		@send 'contentsClicked'
		false

	contentChanged: (-> 
		@setMathQuillContent()
		Ember.$(@element).find('.cursor').remove()
	).observes 'line.content'

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
		console.log 'checkIfInsideEquation'
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
				@insideEquation = true
			else
				@insideEquation = false

`export default EquationRendererComponent`