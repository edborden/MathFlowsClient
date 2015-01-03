attr = DS.attr

class User extends DS.Model
	name: attr()
	layouts: DS.hasMany 'layout'

`export default User`