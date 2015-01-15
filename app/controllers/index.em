class IndexController extends Ember.Controller

	actions:
		newBlock: ->
			block = @store.createRecord 'block',{page:@model}
			@model.blocks.pushObject block

		editBlock: (block) -> @transitionToRoute 'block',block

`export default IndexController`