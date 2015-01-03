attr = DS.attr

class Block extends DS.Model
	content: attr()	
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"
	grid: DS.belongsTo 'grid'
	isNew: attr 'boolean'

`export default Block`