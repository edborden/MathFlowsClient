attr = DS.attr

class Block extends DS.Model
	
	positions: DS.hasMany 'position', {async:true}
	layout: ~> @session.me.layout
	question: attr "boolean"
	content: attr()
	images: DS.hasMany 'image'

`export default Block`