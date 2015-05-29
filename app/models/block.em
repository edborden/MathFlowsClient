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

	+computed test.questionBlocksSorted
	questionNumber: -> 
		@test.questionBlocksSorted.indexOf(@) + 1 + "."

	removeFromPage: ->
		@page.stableBlocks.removeObject @
		@page = null
		@row = null
		@col = null

`export default Block`