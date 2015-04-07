`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Test extends DS.Model

	iconName: "fa-file-text-o"
	pages: DS.hasMany 'page'
	pdfLink: ~> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: ~> @pages.length > 1
	name: attr()
	copyFrom: DS.belongsTo 'test'
	isTest: true

	refreshQuestionNumbers: -> @notifyPropertyChange 'questionBlocksSorted'

	questionBlocksSorted: ~> 
		allBlocks = @pages.getEach 'stableBlocks'
		#allBlocks = allBlocks.getEach 'currentState'
		allBlocksFlat = [].concat.apply [], allBlocks
		allBlocksFlat.filterBy('question').sortBy 'pageNumber','row','col'
		
`export default Test`