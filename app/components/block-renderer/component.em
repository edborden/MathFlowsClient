class BlockRendererComponent extends Ember.Component

	## SETUP

	store: Ember.inject.service()
	modaler:Ember.inject.service()
	modeler:Ember.inject.service()
	eventer:Ember.inject.service()
	session:Ember.inject.service()

	gridstack:null
	block:null
	activeBlock:null
	preview:null

	availableImageHeight: ~> @block.height - @block.linesHeight
	availableImageWidth: ~> @block.width

	## ATTRIBUTE BINDINGS

	attributeBindings: ["tabindex","data-gs-no-resize","data-gs-no-move"]
	"data-gs-no-resize":true
	"data-gs-no-move":true
	tabindex:0

	## CLASSNAMES

	classNames: ["grid-stack-item"]
	classNameBindings: ["active","invalid","borders","preview:preview:editor"]
	active: ~> @activeBlock is @block
	invalid: ~> @block.invalid
	borders: ~> @session.me.preference.borders and @block.question

	## EVENTS

	didInsertElement: ->
		@eventer.on 'syncBlocks', @, @syncAttrsToEl
		@active #initialize observer
		@initializeRenderer()

	initializeRenderer: ->
		@addToGrid()
		isNew = @block.isNew
		@syncAttrsToEl().then =>
			Ember.run.next @,=>
				Ember.$(@element).find(".content").mousedown().mouseup() if isNew

	onActiveChange: (->
		unless @preview
			@gridstack.movable @element,@active
			@gridstack.resizable @element,@active
	).observes 'active'

	willDestroyElement: -> 
		@removeFromGrid()
		@eventer.off 'syncBlocks', @, @syncAttrsToEl

	click: -> 
		console.log 'click'
		@focusElement()
		@setBlockActive()
		
	#focusOut: -> 
	#	console.log 'focusOut',@block.id
	#	@hideResizeHandle()
	#	@setBlockInactive()			

	## HELPERS

	coords: -> Ember.$(@element).data('_gridstack_node')

	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			coords = @coords()
			@block.colSpan = coords.width
			@block.rowSpan = coords.height
			@block.row = coords.y
			@block.col = coords.x
			@block.test.refreshQuestionNumbers() if @block.test?
			@modeler.saveModel(@block).then -> resolve()

	addToGrid: -> 
		assignPosition = not @block.col? or not @block.row?
		@gridstack.add_widget @element,@block.col,@block.row,@block.colSpan,@block.rowSpan,assignPosition

	removeFromGrid: -> @gridstack.remove_widget @element

	focusElement: -> Ember.$(@element).focus()

	##ACTIONS

	actions:
		contentsClicked: -> @setBlockActive()

	setActiveBlock: 'setActiveBlock'
	setBlockActive: -> 
		@sendAction 'setActiveBlock',@block

	setInactiveBlock: 'setInactiveBlock'
	setBlockInactive: ->
		@sendAction 'setInactiveBlock',@block

`export default BlockRendererComponent`