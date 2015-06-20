`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Folder extends DS.Model with ModelName

	iconName: "fa-folder" 
	user: belongsTo 'user', {async:false}
	tests: hasMany 'test'
	name: attr()
	open: attr "boolean"
	folder: belongsTo 'folder', {inverse: 'folders',async:false}
	folders: hasMany 'folder', {inverse: 'folder',async:false}
	testFolder: attr 'boolean'
	studentFolder: attr 'boolean'
	students: hasMany 'student', {async:false}
	hasChildren: ~> @folders.length > 0 or @students.length > 0 or @tests.length > 0
	children: ~> if @testFolder then @tests else @students

`export default Folder`