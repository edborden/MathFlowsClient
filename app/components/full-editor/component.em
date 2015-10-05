`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class FullEditorComponent extends Ember.Component

	model:null
	test: Ember.computed.alias 'model.test'
	store:Ember.inject.service()
	static:null
	session:Ember.inject.service()

	activeItem: null

	actions:
		setActiveItem: (item) ->
			unless @activeItem is item
				@activeItem.goInactive() if @activeItem? and @activeItem.goInactive?
				@activeItem = item
				@activeItem.goActive() if @activeItem? and @activeItem.goActive?

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
			block = @store.createRecord 'block',{page:@model,test:@test,rowSpan:3,colSpan:2,question:true,kind:"question"}
			Ember.run.next @, => @send 'setActiveItem',block

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