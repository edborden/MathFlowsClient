attr = DS.attr

class Invitation extends DS.Model

	## ATTRIBUTES

	referralEmail: attr()
	status: attr()
	updatedAt: attr()

	## COMPUTED

	sent: Ember.computed.equal 'status','sent'
	visited: Ember.computed.equal 'status','visited'
	signedUp: Ember.computed.equal 'status','signed_up'
	statusFormatted: ~>
		if @sent
			"Sent"
		else if @visited
			"Visited"
		else
			"Signed Up!"

`export default Invitation`