`import ModelName from 'math-flows-client/mixins/model-name'`
`import HasBlocks from 'math-flows-client/mixins/has-blocks'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class User extends DS.Model with ModelName,HasBlocks
	name: attr()
	pic: attr()
	premium: attr 'boolean'
	folders: hasMany 'folder', {inverse: 'user'}
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	guest: attr()
	group: belongsTo 'group'

`export default User`