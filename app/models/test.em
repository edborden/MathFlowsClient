`import config from 'math-flows-client/config/environment'`
`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias

class Test extends DS.Model with ModelName

	session: Ember.inject.service()

	# ATTRIBUTES AND ASSOCIATIONS

	iconName: "fa-file-text-o"
	pages: hasMany 'page', {async:false}
	name: attr()
	copyFromId: attr "number"
	folder: belongsTo 'folder', {async:false}

	## COMPUTED

	pdfLink: computed 'session.token', -> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: computed 'pages.length', -> @pages.length > 1
	blocks: computed 'pages.@each.blocks.[]', ->
		allBlocksFlat = []
		@pages.getEach('blocks').forEach (blockArray) ->
			allBlocksFlat.pushObjects blockArray.toArray()
		allBlocksFlat

	## INVALID BLOCKS

	invalidBlocks: computed 'blocks.@each.invalid', -> @blocks.filterBy('page').filterBy 'invalid'
	invalid: computed 'invalidBlocks', -> @invalidBlocks.length isnt 0

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @notifyPropertyChange 'blocks'
	questionBlocksSorted: computed 'blocks', -> @blocks.filterBy('page').filterBy('question').sortBy 'pageNumber','row','col'
		
`export default Test`