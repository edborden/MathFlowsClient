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

	## CLIPBOARD

	clipboard: ~> @stableBlocks.rejectBy 'page'

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @notifyPropertyChange 'questionBlocksSorted'

	questionBlocksSorted: ~> 
		allBlocks = @pages.getEach 'stableBlocks'
		#allBlocks = allBlocks.getEach 'currentState'
		allBlocksFlat = [].concat.apply [], allBlocks
		allBlocksFlat.filterBy('page').filterBy('question').sortBy 'pageNumber','row','col'

	## TEMPORARY FIX FOR EMBER DATA WONKINESS. HAS_MANY RELATIONSHIPS RELOAD ON ANY CHANGE CAUSING VIEWS TO RE-RENDER, BREAKING GRIDSTER.
	blocks: DS.hasMany 'block'
	stableBlocks: null

	loadedBlocks:false

	+observer blocks
	onBlocksChange: ->
		unless @loadedBlocks
			if @blocks.length > 0
				@stableBlocks = Ember.A []
				@stableBlocks.addObjects @blocks
				@loadedBlocks = true
		
`export default Test`