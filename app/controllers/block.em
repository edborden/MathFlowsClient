class BlockController extends Ember.Controller

	creatingEquation: false

	activeSnippet: null

	actions:
		saveSnippet: (snippet) ->
			snippet.save()
			@activeSnippet = null
		destroySnippet: (snippet) ->
			@activeSnippet = null
			snippet.destroyRecord()
		destroyBlock: (block) ->
			block.deleteRecord()
			@send 'back'
			block.save()
		back: -> 
			@creatingEquation = false
			@transitionToRoute 'index'
		makeSnippet: -> 
			@store.createRecord('snippet',{block:@model})
		makeEquation: -> 
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
		editSnippet: (snippet) ->
			@activeSnippet = snippet

`export default BlockController`