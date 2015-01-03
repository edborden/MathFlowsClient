attr = DS.attr

class Block extends DS.Model
	content: attr()	
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"
	layout: DS.belongsTo 'layout'
	isNew: attr 'boolean'

`export default Block`