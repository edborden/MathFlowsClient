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
			@toggleProperty 'creatingEquation'
			false
		newEquation: (equationObj) ->
			@creatingEquation = false
			url = equationObj.exportEquation 'urlencoded'
			latex =  equationObj.exportEquation 'latex'
			snippet = @store.createRecord 'snippet',
				block:@model
				equation: latex
				image: url
			snippet.save()#.then => @model.snippets.pushObject snippet			

`export default BlockController`