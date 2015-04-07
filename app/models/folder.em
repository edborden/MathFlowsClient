attr = DS.attr

class Folder extends DS.Model

	iconName: "fa-folder" 
	user: DS.belongsTo 'user'#, {inverse: 'folders'}
	tests: DS.hasMany 'test', {async:true}
	name: attr()
	open: attr "boolean"
	isFolder: true
	folder: DS.belongsTo 'folder', {inverse: 'folders'}
	folders: DS.hasMany 'folder', {inverse: 'folder'}
	testFolder: attr 'boolean'
	studentFolder: attr 'boolean'
	students: DS.hasMany 'student'
	hasChildren: ~> @folders.length > 0 or @students.length > 0 or @tests.length > 0

`export default Folder`