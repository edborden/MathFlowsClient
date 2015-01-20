attr = DS.attr

class User extends DS.Model
	name: attr()
	pic: attr()
	folders: DS.hasMany 'folder'
	guest: attr()

`export default User`