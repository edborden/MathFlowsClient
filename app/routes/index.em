class IndexRoute extends Ember.Route

	model: ->
		blocks = @store.find 'block'
		console.log blocks
		console.log blocks.length
		if blocks.length isnt 0
			return blocks
		else
			block = @store.createRecord 'block', {content: "+"}
			block.save()
			return [block]

`export default IndexRoute`