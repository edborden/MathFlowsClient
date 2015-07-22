`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Preference extends DS.Model with ModelName

	user: belongsTo 'user', {async:false}
	borders: attr 'boolean'
	directions: attr 'boolean'

`export default Preference`