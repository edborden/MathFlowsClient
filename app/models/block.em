attr = DS.attr

class Block extends DS.Model
	
	snippets: DS.hasMany 'snippet'
	positions: DS.hasMany 'position', {async:true}
	layout: ~> if @user then @user.layout else @positions.firstObject.page.layout
	user: DS.belongsTo 'user'
	question: attr "boolean"

`export default Block`