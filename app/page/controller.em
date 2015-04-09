class PageController extends Ember.Controller

	test: ~> @model.test

	actions:
		createPage: ->
			@store.createRecord('page', {test:@test}).save().then (response) =>
				@transitionToRoute 'page',response
		deletePage: ->
			@model.stableBlocks.forEach (block) -> block.deleteRecord() #delete blocks locally so they don't go to clipboard
			@send 'destroyModel',@model
			firstPage = @test.pages.firstObject
			if firstPage?
				@transitionToRoute 'page',firstPage
			else
				@send 'createPage'
		createBlock: -> 
			block = @store.createRecord('block',{page:@model,test:@test,rowSpan:3,colSpan:2,question:true,content:"[Add content here.]"})
			@model.stableBlocks.addObject block
			@test.blocks.addObject block
		paste: ->
			@test.clipboard.forEach (block) =>
				block.page = @model
				block.send 'becomeDirty'
				@model.stableBlocks.addObject block
			@test.notifyPropertyChange 'clipboard'
				

`export default PageController`