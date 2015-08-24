`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Folder extends DS.Model with ModelName

	## ATTRIBUTES

	iconName: "fa-folder" 
	name: attr()
	open: attr "boolean"
	contents: attr()

	## ASSOCIATIONS

	user: belongsTo 'user', {async:false}
	tests: hasMany 'test'
	folder: belongsTo 'folder', {inverse: 'folders',async:false}
	folders: hasMany 'folder', {inverse: 'folder',async:false}

	## COMPUTED

	testFolder: Ember.computed.equal "contents","tests"
	hasChildren: ~> @folders.length > 0 or @tests.length > 0
	children: Ember.computed.alias 'tests'

`export default Folder`