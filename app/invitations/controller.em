`import growl from 'math-flows-client/utils/growl'`

class InvitationsController extends Ember.Controller

	modeler:Ember.inject.service()
	invitationsSent: Ember.computed.alias 'session.me.invitationsSent'
	referredBy: Ember.computed.alias 'session.me.referredBy'

	actions:

		invite: (email) -> 
			invitation = @store.createRecord 'invitation',{referralEmail:email}
			@modeler.saveModel(invitation).then => 
				growl "Invitation sent!"
				@session.me.invitationsSent.pushObject invitation

`export default InvitationsController`