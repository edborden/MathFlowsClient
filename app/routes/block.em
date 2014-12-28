class BlockRoute extends Ember.Route

	actions:
		save: (block) ->
			console.log 'save'
			block.save().then => @transitionTo 'index'

`export default BlockRoute`