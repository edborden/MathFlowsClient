`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias
observer = Ember.observer
scheduleOnce = Ember.run.scheduleOnce

class EquationRendererComponent extends Ember.Component with HandlesEquations

	# ATTRIBUTES

	active:false
	line:null
	preview:null
	insideEquation: null
	attributeBindings: ['style']

	# SERVICES

	cleaner: service()
	store: service()
	focuser: service()
	keyboarder: service()
	modeler: service()

	# COMPUTED

	questionNumberWidth: alias 'line.block.questionNumberWidth'
	style: Ember.computed 'questionNumberWidth', -> "padding-left:#{@questionNumberWidth}px".htmlSafe()

	# SETUP

	didInitAttrs: ->
		@line.renderer = @ if @line.isLine

	didInsertElement: -> scheduleOnce 'afterRender', @, 'setupMathquill'

	setupMathquill: ->
		@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		@setMathQuillContent()
		@setKeyDownHandler()
		Ember.$(@element).find('.cursor').remove()	

	# BREAKDOWN

	willDestroyElement: -> @removeKeyDownHandler()

	##EVENTS

	onKeyDown: (ev) ->
		unless @preview
			@keyboarder.process @line,ev.keyCode,@mathquill	if @line.isLine
			Ember.run.next @,@checkIfInsideEquation
			true

	focusOut: -> 
		unless @preview
			@active = false
			@insideEquation = false
			@cleaner.clean @line,@mathquill
			cell = @line.cell
			if cell? and cell.isNew
				@modeler.saveModel(cell).then => @modeler.saveModel @line
			else
				@modeler.saveModel @line
			#@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

	click: -> 
		unless @preview
			@active = true
			@checkIfInsideEquation()
		@send 'contentsClicked'
		false

	contentChanged: observer 'line.content', -> 
		@setMathQuillContent()
		Ember.$(@element).find('.cursor').remove()

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
		@mathquill.off 'keydown', '**'

	checkIfInsideEquation: ->
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
				@insideEquation = true
			else
				@insideEquation = false

	actions:
		insertLatex: (latex) ->
			@mathquill.mathquill 'cmd',latex
		menuButtonPressed: (style) ->
			if @line.get style
				@modeler.destroyModel @line.styles.filterBy("effect",style).firstObject
			else
				style = @store.createRecord 'style',{effect:style,line:@line}
				@line.styles.pushObject style
				@modeler.saveModel style

`export default EquationRendererComponent`