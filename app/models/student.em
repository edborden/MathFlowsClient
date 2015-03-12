attr = DS.attr

class Student extends DS.Model

	name: attr()
	email: attr()
	folder: DS.belongsTo 'folder'

`export default Student`