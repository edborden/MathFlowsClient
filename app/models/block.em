attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	positions: DS.hasMany 'position', {async:true}
	layout: ~> @positions.firstObject.page.layout

	question: attr "boolean"

`export default Block`