class PageController extends Ember.Controller

	actions:
		addPage: ->
			@store.createRecord('page', {test:@model.test}).save().then (response) =>
				@transitionToRoute 'page',response
		deletePage: ->
			test = @model.test
			@model.destroyRecord()
			firstPage = test.pages.firstObject
			if firstPage?
				@transitionToRoute 'page',firstPage
			else
				@send 'addPage'
		addBlock: -> 
			block = @store.createRecord('block',{page:@model,rowSpan:3,colSpan:2})
			@model.blocks.addObject block
		deleteBlock: (block) ->
			block.destroyRecord()
		toggleNumber: (block) ->
			block.toggleProperty 'question'
			block.save()
			@model.document.refreshQuestionNumbers()
			@editor.rerender()
		deleteImage: (block) ->
			block.image.destroyRecord()
		registerEditor: (editor) ->
			@editor = editor

	editor: null #PageEditor instance

	+observer model
	onModelChange: ->
		@editor.rerender() if @editor?

`export default PageController`