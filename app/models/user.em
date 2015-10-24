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
  guest: attr 'boolean'
  referredBy: attr 'string'
  invitationId: attr 'number'

  ## ASSOCIATIONS

  tests: hasMany 'test', {async:false}
  folders: hasMany 'folder', {inverse: 'user',async:false}
  group: belongsTo 'group', {async:false,inverse:null}
  preference: belongsTo 'preference', {async:false}
  groupvitations: hasMany 'groupvitations', {async:false}
  groupvitationsSent: hasMany 'groupvitations', {async:false}
  groupvitationsAll: attr 'string' #placeholder for serialized groupvitations on API
  invitationsSent: hasMany 'invitation'
  clips: hasMany 'blocks', {async:false}
  headers: hasMany 'blocks', {async:false}

  ## COMPUTED

  percentOfQuota: computed 'testsCount','testsQuota', -> 
    percent = @testsCount / @testsQuota
    (percent*100).toString() + "%"
  topTestFolders: computed 'folders.[]', -> @folders.rejectBy('folder').filterBy 'testFolder'
  #topStudentFolders: computed 'folders.[]', -> @folders.rejectBy('folder').filterBy 'studentFolder'
  uservoiceURL: computed 'uservoiceToken', -> "http://support.mathflows.com?sso=" + @uservoiceToken
  folderlessTests: computed 'tests.@each.folder', -> @tests.rejectBy 'folder'

  ## FOLDER HANDLING

  iconName: 'fa-user'
  hasChildren: true

`export default User`