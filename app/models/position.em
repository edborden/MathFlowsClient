attr = DS.attr

class Position extends DS.Model

	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"

	block: DS.belongsTo 'block'
	page: DS.belongsTo 'page'

	blockQuestion: ~> @block.question

	question: attr() #proxy for block in API#BlockController#Create

`export default Position`