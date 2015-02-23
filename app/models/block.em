attr = DS.attr

class Block extends DS.Model
	
	positions: DS.hasMany 'position', {async:true}
	layout: ~> @session.me.layout
	user: DS.belongsTo 'user'
	question: attr "boolean"
	content: attr()
	images: DS.hasMany 'image'

`export default Block`