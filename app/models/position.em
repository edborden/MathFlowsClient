attr = DS.attr

class Position extends DS.Model

	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	y: attr "number" #not used
	colWidth: ~> @width / 16
	width: attr "number"
	height: attr "number"

	block: DS.belongsTo 'block'
	page: DS.belongsTo 'page'

	questionBlock: ~> @block.question

	questionNumber: ~> 
		@page.document.questionPositionsSorted.indexOf(@) + 1 + "."

	question: attr() #proxy for block in API#BlockController#Create

`export default Position`