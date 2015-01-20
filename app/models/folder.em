attr = DS.attr

class Folder extends DS.Model

	user: DS.belongsTo 'user'
	flows: DS.hasMany 'flows'
	name: attr()

`export default Folder`