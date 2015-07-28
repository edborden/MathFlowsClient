attr = DS.attr

class Group extends DS.Model

	session: Ember.inject.service()
	
	name: attr()
	users: DS.hasMany 'user', {async:false}
	usersWithoutMe: ~> @users.reject (user) => user is @session.me
	open:false #used for display in tree-over

`export default Group`