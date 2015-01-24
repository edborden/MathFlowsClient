attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	layout: ~> @positions.firstObject.page.layout

	positions: DS.hasMany 'position'

	width: attr "number"
	height: attr "number"
	colWidth: attr "number"

	question: attr "boolean"

`export default Block`