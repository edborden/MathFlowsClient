attr = DS.attr

class Block extends DS.Model
	
	positions: DS.hasMany 'position', {async:true}
	layout: ~> @session.me.layout
	question: attr "boolean"
	content: attr()
	image: DS.belongsTo 'image'

`export default Block`