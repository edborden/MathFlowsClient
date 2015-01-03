attr = DS.attr

class User extends DS.Model
	name: attr()
	grids: DS.hasMany 'grid'

`export default User`