`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Test extends DS.Model

	session: Ember.inject.service()

	iconName: "fa-file-text-o"
	pages: DS.hasMany 'page'
	blocks: DS.hasMany 'block'
	pdfLink: ~> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: ~> @pages.length > 1
	name: attr()
	copyFrom: DS.belongsTo 'test'
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