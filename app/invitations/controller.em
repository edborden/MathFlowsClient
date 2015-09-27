`import growl from 'math-flows-client/utils/growl'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class InvitationsController extends Ember.Controller

	invitationsSent: Ember.computed.alias 'session.me.invitationsSent'
	referredBy: Ember.computed.alias 'session.me.referredBy'

	actions:

		invite: (email) -> 
			invitation = @store.createRecord 'invitation',{referralEmail:email}
			saveModel(invitation).then => 
				growl "Invitation sent!"
				@session.me.invitationsSent.pushObject invitation

`export default InvitationsController`