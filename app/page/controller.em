class PageController extends Ember.Controller

	actions:
		createPage: ->
			@store.createRecord('page', {test:@model.test}).save().then (response) =>
				@transitionToRoute 'page',response
		deletePage: ->
			test = @model.test
			@send 'destroyModel',@model
			firstPage = test.pages.firstObject
			if firstPage?
				@transitionToRoute 'page',firstPage
			else
				@send 'createPage'
		createBlock: -> 
			block = @store.createRecord('block',{page:@model,rowSpan:3,colSpan:2,question:true,content:"[Add content here.]"})
			@model.stableBlocks.addObject block
		registerEditor: (editor) ->
			@editor = editor

	editor: null #PageEditor instance

	+observer model
	onModelChange: ->
		@editor.rerender() if @editor?

`export default PageController`