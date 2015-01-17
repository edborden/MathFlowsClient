class PageController extends Ember.Controller

	actions:
		newBlock: -> @store.createRecord 'block',{page:@model}
		editBlock: (block) -> @transitionToRoute 'block',block
		newPage: ->
			@store.createRecord('page', {document:@model.document}).save().then (response) =>
				@transitionToRoute 'page',response

`export default PageController`