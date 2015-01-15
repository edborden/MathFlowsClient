class IndexController extends Ember.Controller

	actions:
		newBlock: ->
			position = @store.createRecord 'position',{page:@model}
			@model.childPositions.pushObject position

		editBlock: (position) -> @transitionToRoute 'block',position.block

`export default IndexController`