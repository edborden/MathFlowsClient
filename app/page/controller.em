class PageController extends Ember.Controller

	test: ~> @model.test
	modeler:Ember.inject.service()

	activeBlock: null

	actions:
		createPage: ->
			page = @store.createRecord 'page', {test:@test}
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

		setActiveBlock: (block) ->
			@activeBlock = block
			
		setInactiveBlock: (block) ->
			if @activeBlock is block
				@activeBlock = null

		getPDF: ->
			location.href = "http://localhost:3000/tests/45.pdf?token=f9f38e42292925058742ebf1af409585"		

`export default PageController`