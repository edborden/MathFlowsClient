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
			id = @findSnippetEl snippet
			el = Ember.$('#'+id)
			@editor.gridster.remove_widget el
			snippet.destroyRecord()
			el.remove()
			@model.stableSnippets.removeObject snippet
		destroyBlock: (block) ->
			block.positions.forEach (position) -> 
				position.page.stablePositions.removeObject position
				position.deleteRecord()
			block.deleteRecord()
			@send 'back'
			block.save()
		back: -> 
			@creatingEquation = false
			if @originPageModel
				@transitionToRoute 'page',@originPageModel
			else
				@transitionToRoute 'me'
		makeSnippet: (params=null) ->
			params = {block:@model,colSpan:3,rowSpan:1} unless params?
			snippet = @store.createRecord('snippet',params)
			@model.stableSnippets.addObject snippet
		makeEquation: -> 
			@toggleProperty 'creatingEquation'
			false
		newEquation: (equationObj) ->
			@creatingEquation = false
			url = equationObj.exportEquation 'urlencoded'
			latex =  equationObj.exportEquation 'latex'
			params =
				equation: latex
				image: url
				block: @model
			@send 'makeSnippet',params
		editSnippet: (snippet) ->
			@activeSnippet = snippet unless snippet.questionNumber
		fileLoaded: (file) ->
			params =
				image: file.data
				block: @model
			@send 'makeSnippet',params

	findSnippetEl: (snippet) ->
		target = @editor.childViews.findBy 'widget',snippet
		id = target.element.id

`export default BlockController`