attr = DS.attr

class User extends DS.Model
	name: attr()
	pic: attr()
	flows: DS.hasMany 'flow'
	guest: attr()

`export default User`