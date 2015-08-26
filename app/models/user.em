`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class User extends DS.Model with ModelName

	## ATTRIBUTES

	name: attr()
	createdAt: attr()
	pic: attr()
	email: attr()
	testsCount: attr 'number'
	testsQuota: attr 'number'
	premium: attr 'boolean'
	uservoiceToken: attr()
	guest: attr()
	referredBy: attr()

	## ASSOCIATIONS

	blocks: hasMany 'block', {async:false}
	folders: hasMany 'folder', {inverse: 'user',async:false}
	group: belongsTo 'group', {async:false}
	preference: belongsTo 'preference', {async:false}
	groupvitations: hasMany 'groupvitations', {async:false}
	groupvitationsSent: hasMany 'groupvitations', {async:false}
	groupvitationsAll: attr() #placeholder for serialized groupvitations on API
	invitationsSent: hasMany 'invitation'

	## COMPUTED

	percentOfQuota: ~> 
		percent = @testsCount / @testsQuota
		(percent*100).toString() + "%"
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	uservoiceURL: ~> "http://support.mathflows.com?sso=" + @uservoiceToken
	headers: ~> @blocks.filterBy 'header'

	## FOLDER HANDLING

	iconName: 'fa-user'
	hasChildren: true

	## CLIPBOARD
	clipboard: ~> @blocks.rejectBy('header').rejectBy 'page'

`export default User`