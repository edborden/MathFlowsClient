`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Block extends DS.Model with ModelName

	server: Ember.inject.service()

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
	contentInvalid: attr "boolean"

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

	colWidth: ~> @width / 16
	pageNumber: Ember.computed.alias 'page.number'
	test: Ember.computed.alias 'page.test'
	question: Ember.computed.equal 'kind','question'
	header: Ember.computed.equal 'kind','header'

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

	invalid: (-> @contentInvalid or @positionInvalid).property "contentInvalid","positionInvalid"
	positionInvalid: ( -> @row + @rowSpan > 27).property "row","rowSpan"
	invalidationMessage: ( -> 
		if @contentInvalid
			"Content doesn't fit in block." 
		else if @positionInvalid
			"Block doesn't fit on page."
		else
			null
	).property "invalid"

	onInvalidationsChange: (->
		if @isLoaded and @test
			@test.notifyPropertyChange 'invalidBlocks'
	).observes 'invalidations'

	onSizeChange: ( -> @validate() ).observes 'rowSpan','colSpan'

	validate: -> @server.post('blocks/' + @id + '/validate')

	## LINES

	lines: hasMany 'line', {async:false}
	sortedLines: ~> @lines.sortBy 'position'

`export default Block`