attr = DS.attr

class User extends DS.Model
	layout: DS.belongsTo 'layout'
	name: attr()
	pic: attr()
	folders: DS.hasMany 'folder'
	guest: attr()
	headers: DS.hasMany 'position'
	headerPosition: DS.belongsTo 'position'
	group: DS.belongsTo 'group'

`export default User`