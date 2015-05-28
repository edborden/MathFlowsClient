`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Folder extends DS.Model with ModelName

	iconName: "fa-folder" 
	user: belongsTo 'user'#, {inverse: 'folders'}
	tests: hasMany 'test', {async:true}
	name: attr()
	open: attr "boolean"
	folder: belongsTo 'folder', {inverse: 'folders'}
	folders: hasMany 'folder', {inverse: 'folder'}
	testFolder: attr 'boolean'
	studentFolder: attr 'boolean'
	students: hasMany 'student'
	hasChildren: ~> @folders.length > 0 or @students.length > 0 or @tests.length > 0
	children: ~> if @testFolder then @tests else @students

`export default Folder`