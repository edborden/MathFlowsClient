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
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	width: attr "number"
	height: attr "number"
	x: attr "number"
	y: attr "number" #not used
	linesHeight: attr "number"

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
	invalid: ~> @invalidations.firstObject?

	+computed invalid
	invalidationMessage: ->
		if @invalid
			if @invalidations.firstObject.messageType is 1
				"Content doesn't fit in block."
			else
				"Block doesn't fit on the page."
		else
			""

	+observer invalidations
	onInvalidationsChange: ->
		if @isLoaded and @test
			@test.notifyPropertyChange 'invalidBlocks'

	## LINES

	lines: hasMany 'line'
	sortedLines: ~> @lines.sortBy 'position'	

`export default Block`