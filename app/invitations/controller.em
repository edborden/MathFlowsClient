class InvitationsController extends Ember.Controller

	modeler:Ember.inject.service()
	invitationsSent: Ember.computed.alias 'session.me.invitationsSent'
	growler:Ember.inject.service()
	referredBy: Ember.computed.alias 'session.me.referredBy'

	actions:

		invite: (email) -> 
			invitation = @store.createRecord 'invitation',{referralEmail:email}
			@modeler.saveModel(invitation).then => 
				@growler.growl "Invitation sent!"
				@session.me.invitationsSent.pushObject invitation

`export default InvitationsController`