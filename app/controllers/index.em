class IndexController extends Ember.Controller

	actions:
		newBlock: ->

		editBlock: (block) ->
			@transitionToRoute 'block.edit',block

`export default IndexController`