attr = DS.attr

class Session extends DS.Model
	token: attr "string"
	user: DS.belongsTo 'user', {async:false}
	redirectUri: attr "string"
	googleReferrer: attr "string"
	facebookReferrer: attr "string"

`export default Session`