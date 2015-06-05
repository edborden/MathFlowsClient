`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Block extends DS.Model with ModelName
	
	user: belongsTo 'user'
	page: belongsTo 'page'
	image: belongsTo 'image'
	test: belongsTo 'test'

	question: attr "boolean"
	copyFromId: attr "number"
	content: attr()
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	width: attr "number"
	height: attr "number"
	x: attr "number"
	y: attr "number" #not used

	colWidth: ~> @width / 16
	pageNumber: ~> @page.number

	removeFromPage: ->
		@page.stableBlocks.removeObject @
		@page = null
		@row = null
		@col = null

	## QUESTION NUMBER

	+computed test.questionBlocksSorted
	questionNumber: -> 
		@test.questionBlocksSorted.indexOf(@) + 1 + "."

	questionNumberWidth: ->
		if @question
			if @questionNumber < 10
				14
			else if @questionNumber < 100
				24
			else
				34
		else
			0

	## INVALIDATIONS

	invalidations: hasMany 'invalidation'
	invalid: ~> @invalidations.length isnt 0
	contentInvalidation: ~> @invalidations.filterBy('messageType',1).firstObject
	positionInvalidation: ~> @invalidations.filterBy('messageType',2).firstObject

	+observer invalidations
	onInvalidationsChange: ->
		if @isLoaded and @test
			@test.notifyPropertyChange 'invalidBlocks'

`export default Block`