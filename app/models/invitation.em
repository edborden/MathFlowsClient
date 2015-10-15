attr = DS.attr

computed = Ember.computed
equal = computed.equal

class Invitation extends DS.Model

	## ATTRIBUTES

	referralEmail: attr "string"
	status: attr "string"
	updatedAt: attr "string"

	## COMPUTED

	sent: equal "status","sent"
	visited: equal 'status','visited'
	signedUp: equal 'status','signed_up'
	statusFormatted: computed 'status', ->
		if @sent
			"Sent"
		else if @visited
			"Visited"
		else
			"Signed Up!"

`export default Invitation`