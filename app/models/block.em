`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Block extends DS.Model with ModelName

	## ATTRIBUTES

	copyFromId: attr "number"
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	width: attr "number"
	height: attr "number"
	x: attr "number"
	y: attr "number" #not used
	kind: attr()

	## ASSOCIATIONS

	user: belongsTo 'user', {async:false}
	page: belongsTo 'page', {async:false}
	images: hasMany 'image', {async:false}
	tables: hasMany 'table', {async:false}

	## COMPUTED

	children: (->
		childrenFlat = []
		[@images,@tables].forEach (childArray) -> childrenFlat.pushObjects childArray.toArray()
		childrenFlat.sortBy 'blockPosition'
	).property 'images','tables'

	image: Ember.computed.alias 'images.firstObject'
	table: Ember.computed.alias 'tables.firstObject'

	colWidth: ~> @width / 16
	pageNumber: Ember.computed.alias 'page.number'
	test: Ember.computed.alias 'page.test'
	question: Ember.computed.equal 'kind','question'
	header: Ember.computed.equal 'kind','header'
	hasChild: ~> @table or @image

	removeFromPage: ->
		@page.blocks.removeObject @
		@page = null
		@row = null
		@col = null

	## QUESTION NUMBER

	+computed test.questionBlocksSorted
	questionNumber: -> 
		@test.questionBlocksSorted.indexOf(@) + 1

	+computed question,questionNumber
	questionNumberWidth: ->
		questionNumberWidth = if @question
			if @questionNumber < 10
				14
			else if @questionNumber < 100
				24
			else
				34
		else
			0
		questionNumberWidth.toString()

	## INVALIDATIONS

	invalidations: hasMany 'invalidation', {async:false}
	invalid: ~> @invalidations.firstObject?

	+computed invalid
	invalidationMessage: ->
		if @invalid
			if @invalidations.firstObject.message is "content"
				"Content doesn't fit in block."
			else
				"Block doesn't fit on the page."
		else
			""

	onInvalidationsChange: (->
		if @isLoaded and @test
			@test.notifyPropertyChange 'invalidBlocks'
	).observes 'invalidations'

	## LINES

	lines: hasMany 'line', {async:false}
	sortedLines: ~> @lines.sortBy 'position'	

`export default Block`