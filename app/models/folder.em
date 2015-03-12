attr = DS.attr

class Folder extends DS.Model

	iconName: "fa-folder" 
	user: DS.belongsTo 'user', {inverse: 'folders'}
	flows: DS.hasMany 'flows'
	stableFlows: ~> @flows.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	name: attr()
	open: attr "boolean"
	isFolder: true
	folder: DS.belongsTo 'folder', {inverse: 'folders'}
	folders: DS.hasMany 'folder', {inverse: 'folder'}
	stableFolders: ~> @folders.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	flowFolder: attr 'boolean'
	studentFolder: attr 'boolean'
	students: DS.hasMany 'student'
	stableStudents: ~> @students.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	hasChildren: ~> @stableFolders.length > 0 or @stableStudents.length > 0 or @stableFlows.length > 0

`export default Folder`