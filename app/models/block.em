attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	page: DS.belongsTo 'page'
	layout: ~> @page.layout

	#position
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"

	width: attr "number"
	height: attr "number"
	colWidth: attr "number"

`export default Block`