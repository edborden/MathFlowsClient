`import config from 'math-flows-client/config/environment'`
`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Test extends DS.Model with ModelName

	session: Ember.inject.service()

	# ATTRIBUTES AND ASSOCIATIONS

	iconName: "fa-file-text-o"
	pages: hasMany 'page', {async:false}
	name: attr()
	copyFromId: attr "number"
	folder: belongsTo 'folder', {async:false}

	## COMPUTED

	pdfLink: (-> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token).property 'session.token'
	multiplePages: (-> @pages.length > 1).property 'pages.length'
	blocks: (->
		allBlocksFlat = []
		@pages.getEach('blocks').forEach (blockArray) ->
			allBlocksFlat.pushObjects blockArray.toArray()
		allBlocksFlat
	).property 'pages.@each.blocks.[]'

	## INVALID BLOCKS

	invalidBlocks: ~> @blocks.filterBy('page').filterBy 'invalid'
	invalid: ~> @invalidBlocks.length isnt 0

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @notifyPropertyChange 'blocks'
	questionBlocksSorted: ~> @blocks.filterBy('page').filterBy('question').sortBy 'pageNumber','row','col'
		
`export default Test`