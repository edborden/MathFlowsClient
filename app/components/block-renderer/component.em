`import ActiveItem from 'math-flows-client/mixins/active-item'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias
scheduleOnce = Ember.run.scheduleOnce
observer = Ember.observer

class BlockRendererComponent extends Ember.Component with ActiveItem

	# ATTRIBUTES

	classNames: ["grid-stack-item"]
	classNameBindings: ["invalid","borders","preview:preview:editor"]
	attributeBindings: ["tabindex","data-gs-no-resize","data-gs-no-move","data-gs-x","data-gs-y","data-gs-width","data-gs-height"]
	"data-gs-no-resize":true
	"data-gs-no-move":true
	"data-gs-x": alias 'block.col'
	"data-gs-y": alias 'block.row'
	"data-gs-width": alias 'block.colSpan'
	"data-gs-height": alias 'block.rowSpan'
	tabindex:0
	gridstack:null
	block:null
	preview:null

	# SERVICES

	store: service()
	modaler: service()
	eventer: service()
	session: service()

	# COMPUTED

	model: alias 'block'
	invalid: alias 'block.invalid'
	bordersPreference: alias 'session.me.preference.borders'
	question: alias 'block.question'
	borders: computed "bordersPreference","question", -> 
		@bordersPreference and @question
	page: alias 'block.page'

	# SETUP

	didInsertElement: -> scheduleOnce 'afterRender', @, 'setup'

	setup: ->
		@eventer.on 'syncBlocks', @, @syncAttrsToEl
		@active #initialize observer
		@initializeRenderer()

	initializeRenderer: ->
		if @gridstack?
			@addToGrid() 
			if @block.isNew
						@setActiveItem @model,@
						Ember.$(@element).find(".content").mousedown().mouseup()
	
	# BREAKDOWN

	willDestroyElement: -> 
		@eventer.off 'syncBlocks', @, @syncAttrsToEl
		@removeFromGrid()

	## EVENTS

	goActive: ->
		@_super()
		@setEditable() unless @preview

	goInactive: ->
		@_super()
		@setEditable() unless @preview		

	click: -> 
		@setActiveItem @model, @ #override method for ActiveBlock mixin
		false

	## HELPERS

	setEditable: ->
		@gridstack.movable @element,@active
		@gridstack.resizable @element,@active

	coords: -> Ember.$(@element).data('_gridstack_node')

	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			coords = @coords()
			@block.colSpan = coords.width
			@block.rowSpan = coords.height
			@block.row = coords.y
			@block.col = coords.x
			isNew = @block.isNew
			if @block.hasDirtyAttributes
				changed = @block.changedAttributes()
				if changed.rowSpan? or changed.colSpan?
					validate = true
				if @page?
					@page.refreshQuestionNumbers()
					@block.notifyPropertyChange 'invalid'
					@page.notifyPropertyChange 'invalidBlocks'
				saveModel(@block).then => 
					@block.validate() if not isNew and validate?
					resolve()

	addToGrid: -> 
		assignPosition = not @block.col? or not @block.row?
		@gridstack.add_widget @element,@block.col,@block.row,@block.colSpan,@block.rowSpan,assignPosition

	removeFromGrid: -> 
		@gridstack.remove_widget @element if @gridstack.grid?

`export default BlockRendererComponent`