attr = DS.attr

class Session extends DS.Model
	token: attr()
	user: DS.belongsTo 'user', {async:false}
	redirectUri: attr()

`export default Session`