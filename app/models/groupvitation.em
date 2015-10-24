`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
equal = computed.equal

class Groupvitation extends DS.Model with ModelName

  ## ATTRIBUTES
  
  receiverEmail: attr()
  groupName: attr()
  senderName: attr()
  createdAt: attr()
  updatedAt: attr()
  status: attr()

  ## COMPUTED

  declined: equal 'status','declined'
  accepted: equal 'status','accepted'
  sent: equal 'status','sent'
  notAUser: equal 'status','Not signed up'
  completed: computed 'status', -> @status is 'declined' or @status is 'accepted'
  statusFormatted: computed 'status', ->
    if @declined
      "Declined"
    else if @accepted
      "Accepted"
    else if @sent
      "Waiting for response"
    else
      "Not signed up"

`export default Groupvitation`