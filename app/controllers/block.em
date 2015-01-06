class BlockController extends Ember.Controller

	creatingEquation: false

	actions:
		saveSnippet: (snippet) ->
			snippet.save()
		destroySnippet: (snippet) ->
			snippet.destroyRecord()
		destroyBlock: (block) ->
			block.deleteRecord()
			@send 'back'
			block.save()
		back: -> 
			@creatingEquation = false
			@transitionToRoute 'index'
		createSnippet: -> 
			snippet = @store.createRecord('snippet',{block:@model})
			snippet.save().then => @model.snippets.pushObject snippet
		createEquation: ->
			@creatingEquation = true
			false
		newEquation: (equationJson) ->
			snippet = @store.createRecord 'snippet',
				block:@model
				content:equationJson
				equation:true
			snippet.save().then => @model.snippets.pushObject snippet			

`export default BlockController`