attr = DS.attr

class Invitation extends DS.Model
	referrer: DS.belongsTo 'user', {async:false}
	referralEmail: attr()
	referral: DS.belongsTo 'user', {async:false}

`export default Invitation`