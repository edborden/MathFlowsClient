class PageController extends Ember.Controller

	needs: ['block']

	actions:
		newQuestion: -> @store.createRecord 'position',{page:@model,question:true}
		newDirections: -> @store.createRecord 'position',{page:@model,question:false}
		editBlock: (position) -> 
			@controllers.block.originPageModel = @model
			@transitionToRoute 'block',position.block
		newPage: ->
			@store.createRecord('page', {document:@model.document}).save().then (response) =>
				@transitionToRoute 'page',response
		removePage: ->
			document = @model.document
			@model.destroyRecord().then =>
				firstPage = document.pages.firstObject
				if firstPage?
					@transitionToRoute 'page',firstPage
				else
					@send 'newPage'

`export default PageController`