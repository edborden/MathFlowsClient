`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Groupvitation extends DS.Model with ModelName
	
	receiverEmail: attr()
	groupName: attr()
	senderName: attr()
	receiverId: attr "number"
	declined: attr 'boolean'
	accepted: attr 'boolean'
	createdAt: attr()
	updatedAt: attr()
	status: ~>
		if @declined
			"Declined"
		else if @accepted
			"Accepted"
		else if @receiverId
			"Waiting for response"
		else
			"Not signed up"


`export default Groupvitation`