attr = DS.attr

class Invitation extends DS.Model
	referrer: DS.belongsTo 'user'
	referralEmail: attr()
	referral: DS.belongsTo 'user'

`export default Invitation`