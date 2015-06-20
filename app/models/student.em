attr = DS.attr

class Student extends DS.Model

	iconName: "fa-user"
	name: attr()
	email: attr()
	folder: DS.belongsTo 'folder', {async:false}

`export default Student`