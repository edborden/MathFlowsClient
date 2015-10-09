`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias
equal = computed.equal
service = Ember.inject.service
observer = Ember.observer

class Block extends DS.Model with ModelName

	server: service()

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
	kind: attr "string"
	contentInvalid: attr "boolean"

	## ASSOCIATIONS

	user: belongsTo 'user', {async:false}
	page: belongsTo 'page', {async:false}
	images: hasMany 'image', {async:false}
	tables: hasMany 'table', {async:false}

	## COMPUTED

	children: computed 'images','tables', ->
		childrenFlat = []
		[@images,@tables].forEach (childArray) -> childrenFlat.pushObjects childArray.toArray()
		childrenFlat.sortBy 'blockPosition'
	pageNumber: alias 'page.number'
	test: alias 'page.test'
	question: equal 'kind','question'
	header: equal 'kind','header'
	questionBlocksSorted: alias 'test.questionBlocksSorted'

	removeFromPage: ->
		@page.blocks.removeObject @
		@page = null
		@row = null
		@col = null

	## QUESTION NUMBER

	questionNumber: computed 'questionBlocksSorted', -> 
		@questionBlocksSorted.indexOf(@) + 1 if @page and @question

	questionNumberWidth: computed 'question','questionNumber', ->
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

	invalid: computed "contentInvalid","positionInvalid", -> 
		@contentInvalid or @positionInvalid
	positionInvalid: computed  "row","rowSpan", -> @row + @rowSpan > 27
	invalidationMessage: computed 'invalid', -> 
		if @contentInvalid
			"Content doesn't fit in block." 
		else if @positionInvalid
			"Block doesn't fit on page."
		else
			null

	onSizeChange: observer 'rowSpan','colSpan', -> @validate()

	validate: -> 
		if @id? and @row? and @col?
			@server.post 'blocks/' + @id + '/validate'

	## LINES

	lines: hasMany 'line', {async:false}
	sortedLines: computed 'lines', -> @lines.sortBy 'position'

`export default Block`