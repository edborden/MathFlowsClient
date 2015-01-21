attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	equation: attr()
	image: attr()
	
	block: DS.belongsTo 'block'

	#position
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	x: attr "number"
	y: attr "number"

	width: attr "number"
	height: attr "number"

`export default Snippet`