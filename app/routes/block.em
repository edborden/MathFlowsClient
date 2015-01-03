class BlockRoute extends Ember.Route

	actions:
		save: (block) ->
			block.save().then => @transitionTo 'index'
		delete: (block) ->
			block.destroyRecord().then => @transitionTo 'index'

`export default BlockRoute`