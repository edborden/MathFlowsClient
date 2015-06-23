class PageController extends Ember.Controller

	test: ~> @model.test
	modeler:Ember.inject.service()

	actions:
		createPage: ->
			page = @store.createRecord('page', {test:@test})
			@modeler.saveModel(page).then (response) =>
				@transitionToRoute 'page',response
		deletePage: ->
			@model.blocks.forEach (block) => block.deleteRecord() #delete blocks locally so they don't go to clipboard
			@modeler.destroyModel @model
			firstPage = @test.pages.firstObject
			if firstPage?
				@transitionToRoute 'page',firstPage
			else
				@send 'createPage'
		createBlock: -> 
			@store.createRecord 'block',{page:@model,test:@test,rowSpan:3,colSpan:2,question:true,linesHeight:18}
		paste: ->
			@test.clipboard.forEach (block) =>
				block.page = @model
				block.send 'becomeDirty'
				@model.blocks.addObject block
			@test.notifyPropertyChange 'clipboard'
				

`export default PageController`