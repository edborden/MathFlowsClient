attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	page: DS.belongsTo 'page'
	layout: ~> @page.layout

	#position
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number", {defaultValue:2}
	colSpan: attr "number", {defaultValue:2}

	width: attr "number"
	height: attr "number"
	colWidth: attr "number"

	question: attr "boolean"

`export default Block`