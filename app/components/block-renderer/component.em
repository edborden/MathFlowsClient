class BlockRendererComponent extends Ember.Component

	## SETUP

	store: Ember.inject.service()
	modaler:Ember.inject.service()
	modeler:Ember.inject.service()

	gridstack:null
	block:null
	activeBlock:null
	activeEquationLine: null

	attributeBindings: ["tabindex","data-gs-no-resize","data-gs-no-move"]
	classNames: ["grid-stack-item"]
	classNameBindings: ["active","invalid"]

	"data-gs-no-resize":true
	"data-gs-no-move":true
	tabindex:0

	active: ~> @activeBlock is @block
	invalid: ~> @block.invalid

	availableImageHeight: ~> @block.height - @block.linesHeight
	availableImageWidth: ~> @block.width

	## EVENTS

	didInsertElement: ->
		@parent.on 'syncBlocks', @, @syncAttrsToEl
		@active #initialize observer
		if @gridstack?
			@initializeRenderer()
		else
			Ember.run.next @, @initializeRenderer #run after render to allow gridstack/page-editor to initialize

	initializeRenderer: ->
		@addToGrid()
		isNew = @block.isNew
		@syncAttrsToEl().then =>
			Ember.run.next @,=>
				Ember.$(@element).find(".content").mousedown().mouseup() if isNew

	+observer active
	onActiveChange: ->
		@gridstack.movable @element,@active
		@gridstack.resizable @element,@active
		@setResizeHandle @active

	willDestroyElement: -> 
		@refreshQuestionNumbers()
		@removeFromGrid()
		@parent.off 'syncBlocks', @, @syncAttrsToEl

	click: -> 
		console.log 'click'
		@focusElement()
		@setBlockActive()
		
	#focusOut: -> 
	#	console.log 'focusOut',@block.id
	#	@hideResizeHandle()
	#	@setBlockInactive()			

	## HELPERS

	moveToTop: -> Ember.$(@element).parent().append Ember.$(@element)

	setResizeHandle: (active) ->
		handle = Ember.$(@element).find(".ui-resizable-handle")
		if active
			handle.show() if handle
		else
			handle.hide()		

	coords: -> Ember.$(@element).data('_gridstack_node')

	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			coords = @coords()
			@block.colSpan = coords.width
			@block.rowSpan = coords.height
			@block.row = coords.y
			@block.col = coords.x
			@refreshQuestionNumbers()
			@modeler.saveModel(@block).then -> resolve()

	addToGrid: -> 
		assignPosition = not @block.col? or not @block.row?
		@gridstack.add_widget @element,@block.col,@block.row,@block.colSpan,@block.rowSpan,assignPosition

	removeFromGrid: -> @gridstack.remove_widget @element

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test

	focusElement: -> Ember.$(@element).focus()

	##ACTIONS

	actions:
		contentsClicked: -> @setBlockActive()

		activeEquationLine: (mathquill) ->
			@activeEquationLine = mathquill unless @activeEquationLine is mathquill

		inactiveEquationLine: (mathquill) ->
			@activeEquationLine = null if @activeEquationLine is mathquill

	setActiveBlock: 'setActiveBlock'
	setBlockActive: -> 
		@sendAction 'setActiveBlock',@block

	setInactiveBlock: 'setInactiveBlock'
	setBlockInactive: ->
		@sendAction 'setInactiveBlock',@block

`export default BlockRendererComponent`