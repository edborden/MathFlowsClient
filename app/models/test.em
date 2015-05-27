`import config from 'math-flows-client/config/environment'`
`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Test extends DS.Model with ModelName

	session: Ember.inject.service()

	iconName: "fa-file-text-o"
	pages: hasMany 'page'
	blocks: hasMany 'block'
	pdfLink: ~> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: ~> @pages.length > 1
	name: attr()
	copyFrom: belongsTo 'test'
	isTest: true

	## CLIPBOARD

	clipboard: ~> @blocks.rejectBy 'page'

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @notifyPropertyChange 'questionBlocksSorted'

	questionBlocksSorted: ~> 
		allBlocks = @pages.getEach 'stableBlocks'
		#allBlocks = allBlocks.getEach 'currentState'
		allBlocksFlat = [].concat.apply [], allBlocks
		allBlocksFlat.filterBy('page').filterBy('question').rejectBy('isDeleted').sortBy 'pageNumber','row','col'
		
`export default Test`