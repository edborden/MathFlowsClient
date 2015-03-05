class PageController extends Ember.Controller

	actions:
		addPage: ->
			@store.createRecord('page', {document:@model.document}).save().then (response) =>
				@transitionToRoute 'page',response
		deletePage: ->
			document = @model.document
			@model.destroyRecord().then =>
				firstPage = document.pages.firstObject
				if firstPage?
					@transitionToRoute 'page',firstPage
				else
					@send 'newPage'
		addBlock: -> 
			pos = @store.createRecord('position',{page:@model,rowSpan:3,colSpan:2})
			@model.stablePositions.addObject pos
		deleteBlock: (block) ->
			block.positions.forEach (position) -> 
				position.page.stablePositions.removeObject position
				position.deleteRecord()
			block.deleteRecord()
			block.save()
		addNumber: (block) ->
			block.question = true
			block.save()
			@model.document.refreshQuestionNumbers()
		deleteNumber: (block) ->
			block.question = false
			block.save()
			@model.document.refreshQuestionNumbers()
		deleteImage: (block) ->
			block.image.destroyRecord()

`export default PageController`