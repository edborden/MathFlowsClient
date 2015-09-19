service = Ember.inject.service
computed = Ember.computed
alias = computed.alias
scheduleOnce = Ember.run.scheduleOnce
observer = Ember.observer

class BlockRendererComponent extends Ember.Component

	# ATTRIBUTES

	classNames: ["grid-stack-item"]
	classNameBindings: ["active","invalid","borders","preview:preview:editor"]
	attributeBindings: ["tabindex","data-gs-no-resize","data-gs-no-move"]
	"data-gs-no-resize":true
	"data-gs-no-move":true
	tabindex:0
	gridstack:null
	block:null
	activeBlock:null
	preview:null

	# SERVICES

	store: service()
	modaler: service()
	modeler: service()
	eventer: service()
	session: service()

	# COMPUTED

	invalid: alias 'block.invalid'
	active: computed "activeBlock", -> @activeBlock is @block
	bordersPreference: alias 'session.me.preference.borders'
	question: alias 'block.question'
	borders: computed "bordersPreference","question", -> 
		@bordersPreference and @question

	# SETUP

	didInsertElement: -> scheduleOnce 'afterRender', @, 'setup'

	setup: ->
		@eventer.on 'syncBlocks', @, @syncAttrsToEl
		@active #initialize observer
		@initializeRenderer()

	initializeRenderer: ->
		@addToGrid()
		isNew = @block.isNew
		@syncAttrsToEl().then =>
			Ember.run.next @,=>
				Ember.$(@element).find(".content").mousedown().mouseup() if isNew
	
	# BREAKDOWN

	## EVENTS

	onActiveChange: Ember.observer 'active', ->
		unless @preview
			@gridstack.movable @element,@active
			@gridstack.resizable @element,@active

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