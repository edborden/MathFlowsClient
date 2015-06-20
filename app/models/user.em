`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class User extends DS.Model with ModelName
	name: attr()
	pic: attr()
	premium: attr 'boolean'
	blocks: hasMany 'block', {async:false}
	folders: hasMany 'folder', {inverse: 'user',async:false}
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	guest: attr()
	group: belongsTo 'group', {async:false}

`export default User`