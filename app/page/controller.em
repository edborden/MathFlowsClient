`import ActiveBlock from 'math-flows-client/mixins/active-block'`

class PageController extends Ember.Controller with ActiveBlock

	test: Ember.computed.alias 'model.test'
	modeler:Ember.inject.service()

	actions:
		createPage: ->
			page = @store.createRecord 'page', {test:@test}
			@modeler.saveModel(page).then (response) =>
				@transitionToRoute 'page',response

		deletePage: ->
			@model.blocks.toArray().forEach (block) -> block.deleteRecord() #delete blocks locally so they don't go to clipboard
			firstPage = @test.pages.firstObject
			@transitionToRoute 'page',firstPage
			@modeler.destroyModel @model

		createBlock: -> 
			block = @store.createRecord 'block',{page:@model,test:@test,rowSpan:3,colSpan:2,question:true,linesHeight:18}
			Ember.run.next @, => @send 'setActiveBlock',block

		paste: ->
			@test.clipboard.forEach (block) =>
				block.page = @model
				block.send 'becomeDirty'
				@model.blocks.addObject block
			@test.notifyPropertyChange 'clipboard'

`export default PageController`