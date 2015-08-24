`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Groupvitation extends DS.Model with ModelName

	## ATTRIBUTES
	
	receiverEmail: attr()
	groupName: attr()
	senderName: attr()
	createdAt: attr()
	updatedAt: attr()
	status: attr()

	## COMPUTED

	declined: Ember.computed.equal 'status','declined'
	accepted: Ember.computed.equal 'status','accepted'
	sent: Ember.computed.equal 'status','sent'
	notAUser: Ember.computed.equal 'status','Not signed up'
	statusFormatted: ~>
		if @declined
			"Declined"
		else if @accepted
			"Accepted"
		else if @sent
			"Waiting for response"
		else if @notAUser
			"Not signed up"
		else
			"Processing..."

`export default Groupvitation`