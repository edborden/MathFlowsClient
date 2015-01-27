attr = DS.attr

class Folder extends DS.Model

	user: DS.belongsTo 'user', {inverse: 'folders'}
	flows: DS.hasMany 'flows'
	name: attr()

`export default Folder`