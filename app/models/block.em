attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	layout: DS.belongsTo 'layout'
	page: DS.belongsTo 'page'

	#position
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"

`export default Block`