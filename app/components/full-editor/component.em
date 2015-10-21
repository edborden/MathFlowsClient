`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

`import ActiveSetter from 'math-flows-client/mixins/active-setter'`

class FullEditorComponent extends Ember.Component with ActiveSetter

	# ATTRIBUTES

	model: null
	static: null

	# SERVICES

	store: service()
	session: service()
	eventer: service()
	keen: service()

	# COMPUTED
	test: alias 'model.test'

	# SETUP

	didInsertElement: ->
		@eventer.on 'activeObjChanged', @, @setActiveItemNull

	# BREAKDOWN

	willDestroyElement: ->
		@eventer.off 'activeObjChanged', @, @setActiveItemNull

	# HELPERS

	setActiveItemNull: ->
		@send 'setActiveItem', null
		
	# ACTIONS

	actions:

		createPage: ->
			@send 'setActiveItem', null
			page = @store.createRecord 'page', {test:@test}
			saveModel(page).then (response) =>
				@model = response
			@keen.addEditorEvent "createPage",@test

		deletePage: ->
			@send 'setActiveItem', null
			model = @model
			@send 'previousPage'
			model.blocks.toArray().forEach (block) -> block.deleteRecord() #delete blocks locally so they don't go to clipboard
			destroyModel model

		createBlock: -> 
			block = @store.createRecord 'block',{page:@model,rowSpan:3,colSpan:2,kind:'question'}
			@keen.addEditorEvent 'createBlock', block

		paste: ->
			@session.me.clipboard.forEach (block) =>
				block.page = @model
			@session.me.notifyPropertyChange 'clipboard'
			@keen.addEditorEvent 'pasteBlocks',@model

		previousPage: -> 
			@send 'setActiveItem', null
			@model = @model.previousPage

		nextPage: -> 
			@send 'setActiveItem', null
			@model = @model.nextPage

`export default FullEditorComponent`