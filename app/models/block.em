`import Model from 'math-flows-client/lib/model'`

attr = DS.attr
belongsTo = DS.belongsTo

class Block extends Model
	
	user: belongsTo 'user'
	page: belongsTo 'page'
	image: belongsTo 'image'
	test: ~> @page.test

	isABlock: true
	question: attr "boolean"
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

	+computed page.test.questionBlocksSorted
	questionNumber: -> 
		@page.test.questionBlocksSorted.indexOf(@) + 1 + "."

`export default Block`