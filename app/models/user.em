attr = DS.attr

class User extends DS.Model
	layout: DS.belongsTo 'layout'
	name: attr()
	pic: attr()
	folders: DS.hasMany 'folder'
	guest: attr()
	header: DS.belongsTo 'block'
	headerPosition: DS.belongsTo 'position'

`export default User`