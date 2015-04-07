attr = DS.attr

class Block extends DS.Model
	user: DS.belongsTo 'user'
	page: DS.belongsTo 'page'
	image: DS.belongsTo 'image'

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