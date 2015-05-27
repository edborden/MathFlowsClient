attr = DS.attr

class Group extends DS.Model

	session: Ember.inject.service()
	
	name: attr()
	users: DS.hasMany 'user'
	usersWithoutMe: ~> @users.reject (user) => user is @session.me

`export default Group`