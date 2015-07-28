`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class User extends DS.Model with ModelName
	name: attr()
	createdAt: attr()
	pic: attr()
	email: attr()
	uservoiceToken: attr()
	premium: attr 'boolean'
	blocks: hasMany 'block', {async:false}
	folders: hasMany 'folder', {inverse: 'user',async:false}
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	guest: attr()
	group: belongsTo 'group', {async:false}
	preference: belongsTo 'preference', {async:false}

	iconName: 'fa-user'
	hasChildren: true

	uservoiceURL: ~> "http://support.mathflows.com?sso=" + @uservoiceToken
	headers: ~> @blocks.filterBy 'header'

	## CLIPBOARD

	clipboard: ~> @blocks.rejectBy('header').rejectBy 'page'

`export default User`