`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Preference extends DS.Model with ModelName

  user: belongsTo 'user', {async:false}
  borders: attr 'boolean'
  directions: attr 'boolean'
  tour: attr 'boolean'
  groupHelp: attr 'boolean'
  meGroupHelp: attr 'boolean'
  meTestHelp: attr 'boolean'

`export default Preference`