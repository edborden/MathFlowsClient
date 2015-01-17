class PageController extends Ember.Controller

	actions:
		newBlock: -> @store.createRecord 'block',{page:@model}
		editBlock: (block) -> @transitionToRoute 'block',block
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