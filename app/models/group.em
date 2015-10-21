`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Group extends DS.Model with ModelName

	session: Ember.inject.service()
	
	name: attr "string"
	users: hasMany "user", {async:false}

`export default Group`