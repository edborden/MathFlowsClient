attr = DS.attr

class Session extends DS.Model
	token: attr()
	user: DS.belongsTo 'user'
	redirectUri: attr()

`export default Session`