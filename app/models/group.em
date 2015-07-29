`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Group extends DS.Model with ModelName

	session: Ember.inject.service()
	
	name: attr()
	users: DS.hasMany 'user', {async:false}
	usersWithoutMe: ~> @users.reject (user) => user is @session.me
	open:false #used for display in tree-over

`export default Group`