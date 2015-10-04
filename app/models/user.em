`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias

class User extends DS.Model with ModelName

	## ATTRIBUTES

	name: attr 'string'
	createdAt: attr 'string'
	pic: attr 'string'
	email: attr 'string'
	testsCount: attr 'number'
	testsQuota: attr 'number'
	premium: attr 'boolean'
	uservoiceToken: attr 'string'
	guest: attr 'string'
	referredBy: 'string'

	## ASSOCIATIONS

	blocks: hasMany 'block', {async:false}
	folders: hasMany 'folder', {inverse: 'user',async:false}
	group: belongsTo 'group', {async:false}
	preference: belongsTo 'preference', {async:false}
	groupvitations: hasMany 'groupvitations', {async:false}
	groupvitationsSent: hasMany 'groupvitations', {async:false}
	groupvitationsAll: attr 'string' #placeholder for serialized groupvitations on API
	invitationsSent: hasMany 'invitation'

	## COMPUTED

	percentOfQuota: computed 'testsCount','testsQuota', -> 
		percent = @testsCount / @testsQuota
		(percent*100).toString() + "%"
	topTestFolders: computed 'folders.[]', -> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: computed 'folders.[]', -> @folders.rejectBy('folder').filterBy 'studentFolder'
	uservoiceURL: computed 'uservoiceToken', -> "http://support.mathflows.com?sso=" + @uservoiceToken
	headers: computed 'blocks.[]', -> @blocks.filterBy 'header'

	## FOLDER HANDLING

	iconName: 'fa-user'
	hasChildren: true

	## CLIPBOARD
	clipboard: computed 'blocks.[]', -> @blocks.rejectBy('header').rejectBy 'page'

`export default User`