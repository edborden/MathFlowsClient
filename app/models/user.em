attr = DS.attr

class User extends DS.Model
	name: attr()
	flows: DS.hasMany 'flow'
	guest: attr()

`export default User`