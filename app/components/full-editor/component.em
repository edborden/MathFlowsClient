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
			@setActiveItem null
			page = @store.createRecord 'page', {test:@test}
			saveModel(page).then (response) =>
				@model = response

		deletePage: ->
			@setActiveItem null
			model = @model
			model.blocks.toArray().forEach (block) -> block.deleteRecord() #delete blocks locally so they don't go to clipboard
			firstPage = @test.pages.firstObject
			@model = firstPage
			destroyModel model

		createBlock: -> 
			block = @store.createRecord 'block',{page:@model,test:@test,rowSpan:3,colSpan:2,kind:'question'}

		paste: ->
			@session.me.clipboard.forEach (block) =>
				block.page = @model
				block.send 'becomeDirty'
				@model.blocks.addObject block
			@session.me.notifyPropertyChange 'clipboard'

		previousPage: -> 
			@setActiveItem null
			@model = @model.previousPage

		nextPage: -> 
			@setActiveItem null
			@model = @model.nextPage

`export default FullEditorComponent`