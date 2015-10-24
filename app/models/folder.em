computed = Ember.computed
alias = computed.alias
equal = computed.equal

`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Folder extends DS.Model with ModelName

  ## ATTRIBUTES

  iconName: "fa-folder" 
  name: attr "string"
  open: attr "boolean"
  contents: attr "string"

  ## ASSOCIATIONS

  user: belongsTo 'user', {async:false}
  tests: hasMany 'test', {async:true}
  folder: belongsTo 'folder', {inverse: 'folders',async:false}
  folders: hasMany 'folder', {inverse: 'folder',async:false}

  ## COMPUTED

  testFolder: equal "contents","tests"
  foldersLength: alias 'folders.length'
  testsLength: alias 'tests.length'
  hasChildren: computed 'foldersLength','testsLength', -> @foldersLength > 0 or @testsLength > 0
  children: alias 'tests'

`export default Folder`