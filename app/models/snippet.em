attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	block: DS.belongsTo 'block'
	equation: attr()
	image: attr()
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"

`export default Snippet`