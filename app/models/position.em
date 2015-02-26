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

	user: DS.belongsTo 'user', {inverse: 'headers'}
	block: DS.belongsTo 'block'
	page: DS.belongsTo 'page'

	questionBlock: ~> @block.question

	questionNumber: ~> 
		@page.document.questionPositionsSorted.indexOf(@) + 1 + "."

`export default Position`