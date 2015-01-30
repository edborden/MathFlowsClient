attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	positions: DS.hasMany 'position', {async:true}
	layout: ~> @session.me.layout
	user: DS.belongsTo 'user'
	question: attr "boolean"

	loadedSnippets:false

	+observer snippets
	onSnippetsChange: ->
		unless @loadedSnippets
			if @snippets.length > 0
				@stableSnippets = Ember.A []
				@stableSnippets.addObjects @snippets
				@loadedSnippets = true

	stableSnippets: null

`export default Block`