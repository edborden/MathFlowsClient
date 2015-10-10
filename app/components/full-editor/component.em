`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class FullEditorComponent extends Ember.Component

	model: null
	test: alias 'model.test'
	store: Ember.inject.service()
	static: null
	session: service()

	activeItem: null
	activeItemRenderer: null

	actions:
		setActiveItem: (item,renderer) ->
			unless @activeItem is item
				@activeItemRenderer.goInactive() if @activeItemRenderer? and @activeItemRenderer.goInactive?
				@activeItem = item
				@activeItemRenderer = renderer
				@activeItemRenderer.goActive() if @activeItemRenderer? and @activeItemRenderer.goActive?

		createPage: ->
			@send 'setActiveItem', null
			page = @store.createRecord 'page', {test:@test}
			saveModel(page).then (response) =>
				@model = response

		deletePage: ->
			@send 'setActiveItem', null
			model = @model
			@send 'previousPage'
			model.blocks.toArray().forEach (block) -> block.deleteRecord() #delete blocks locally so they don't go to clipboard
			destroyModel model

		createBlock: -> 
			block = @store.createRecord 'block',{page:@model,test:@test,rowSpan:3,colSpan:2,kind:'question'}

		paste: ->
			@session.me.clipboard.forEach (block) =>
				block.test = @test
				block.page = @model
			@session.me.notifyPropertyChange 'clipboard'

		previousPage: -> 
			@send 'setActiveItem', null
			@model = @model.previousPage

		nextPage: -> 
			@send 'setActiveItem', null
			@model = @model.nextPage

`export default FullEditorComponent`