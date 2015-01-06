attr = DS.attr

class Block extends DS.Model
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"
	layout: DS.belongsTo 'layout'
	snippets: DS.hasMany 'snippet'

`export default Block`