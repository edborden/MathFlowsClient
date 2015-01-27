class BlockController extends Ember.Controller

	originPageModel: null
	creatingEquation: false
	activeSnippet: null

	actions:
		registerEditor: (editor) ->
			@editor = editor
		saveSnippet: (snippet) ->
			snippet.save()
			@activeSnippet = null
		destroySnippet: (snippet) ->
			@activeSnippet = null
			block = snippet.block
			id = @findSnippetEl snippet
			el = Ember.$('#'+id)
			@editor.gridster.remove_widget el
			snippet.destroyRecord()
			el.remove()
		destroyBlock: (block) ->
			block.positions.forEach (position) -> position.deleteRecord() if position?
			block.deleteRecord()
			@send 'back'
			block.save()
		back: -> 
			@creatingEquation = false
			if @originPageModel
				@transitionToRoute 'page',@originPageModel
			else
				@transitionToRoute 'me'
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
				equation: latex
				image: url
				block: @model
		editSnippet: (snippet) ->
			@activeSnippet = snippet unless snippet.questionNumber
		fileLoaded: (file) ->
			snippet = @store.createRecord 'snippet',
				image: file.data
				block: @model

	findSnippetEl: (snippet) ->
		target = @editor.childViews.findBy 'widget',snippet
		id = target.element.id

`export default BlockController`